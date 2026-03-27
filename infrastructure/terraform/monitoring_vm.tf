data "aws_ami" "debian_12" {
  most_recent = true
  owners      = ["136693071363"] # Debian official AWS account

  filter {
    name   = "name"
    values = ["debian-12-amd64-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

data "aws_iam_policy_document" "monitoring_backup_assume_role" {
  count = var.monitoring_enabled && var.monitoring_backup_s3_bucket != null ? 1 : 0

  statement {
    effect = "Allow"
    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
    actions = ["sts:AssumeRole"]
  }
}

data "aws_iam_policy_document" "monitoring_backup_s3_access" {
  count = var.monitoring_enabled && var.monitoring_backup_s3_bucket != null ? 1 : 0

  statement {
    sid    = "ListBackupBucket"
    effect = "Allow"
    actions = [
      "s3:ListBucket",
    ]
    resources = [
      "arn:aws:s3:::${var.monitoring_backup_s3_bucket}",
    ]
  }

  statement {
    sid    = "WriteBackupObjects"
    effect = "Allow"
    actions = [
      "s3:PutObject",
      "s3:AbortMultipartUpload",
      "s3:ListMultipartUploadParts",
    ]
    resources = [
      "arn:aws:s3:::${var.monitoring_backup_s3_bucket}/*",
    ]
  }
}

resource "aws_iam_role" "monitoring_backup" {
  count = var.monitoring_enabled && var.monitoring_backup_s3_bucket != null ? 1 : 0

  name               = "${local.name_prefix}-monitoring-backup-role"
  assume_role_policy = data.aws_iam_policy_document.monitoring_backup_assume_role[0].json
  tags               = local.tags
}

resource "aws_iam_role_policy" "monitoring_backup_s3_access" {
  count = var.monitoring_enabled && var.monitoring_backup_s3_bucket != null ? 1 : 0

  name   = "${local.name_prefix}-monitoring-backup-s3-policy"
  role   = aws_iam_role.monitoring_backup[0].id
  policy = data.aws_iam_policy_document.monitoring_backup_s3_access[0].json
}

resource "aws_iam_instance_profile" "monitoring_backup" {
  count = var.monitoring_enabled && var.monitoring_backup_s3_bucket != null ? 1 : 0

  name = "${local.name_prefix}-monitoring-backup-profile"
  role = aws_iam_role.monitoring_backup[0].name
  tags = local.tags
}

resource "aws_security_group" "monitoring_vm" {
  count = var.monitoring_enabled ? 1 : 0

  name        = "${local.name_prefix}-monitoring-vm-sg"
  description = "Security group for monitoring Debian VM"
  vpc_id      = module.vpc.vpc_id

  tags = merge(local.tags, { Name = "${local.name_prefix}-monitoring-vm-sg" })
}

resource "aws_vpc_security_group_ingress_rule" "monitoring_grafana" {
  for_each = var.monitoring_enabled ? toset(var.monitoring_allowed_cidrs) : []

  security_group_id = aws_security_group.monitoring_vm[0].id
  from_port         = 3000
  to_port           = 3000
  ip_protocol       = "tcp"
  cidr_ipv4         = each.key
  description       = "Allow Grafana HTTP access"
}

resource "aws_vpc_security_group_ingress_rule" "monitoring_ssh" {
  for_each = var.monitoring_enabled ? toset(var.monitoring_ssh_allowed_cidrs) : []

  security_group_id = aws_security_group.monitoring_vm[0].id
  from_port         = 22
  to_port           = 22
  ip_protocol       = "tcp"
  cidr_ipv4         = each.key
  description       = "Allow SSH access"
}

resource "aws_vpc_security_group_egress_rule" "monitoring_all_outbound" {
  count = var.monitoring_enabled ? 1 : 0

  security_group_id = aws_security_group.monitoring_vm[0].id
  ip_protocol       = "-1"
  cidr_ipv4         = "0.0.0.0/0"
  description       = "Allow all outbound traffic"
}

resource "aws_instance" "monitoring_vm" {
  count = var.monitoring_enabled ? 1 : 0

  ami           = data.aws_ami.debian_12.id
  instance_type = var.monitoring_instance_type
  key_name      = var.monitoring_key_name

  subnet_id                   = module.vpc.public_subnets[0]
  vpc_security_group_ids      = [aws_security_group.monitoring_vm[0].id]
  associate_public_ip_address = true
  iam_instance_profile        = var.monitoring_backup_s3_bucket != null ? aws_iam_instance_profile.monitoring_backup[0].name : null

  root_block_device {
    volume_size           = var.monitoring_root_volume_size
    volume_type           = "gp3"
    encrypted             = true
    delete_on_termination = true
  }

  user_data = templatefile("${path.module}/../../monitoring/debian/bootstrap.sh.tftpl", {
    grafana_admin_user     = var.grafana_admin_user
    grafana_admin_password = var.grafana_admin_password
    prometheus_url         = var.monitoring_prometheus_url
    backup_s3_bucket       = var.monitoring_backup_s3_bucket
    backup_cron            = var.monitoring_backup_cron
    aws_region             = var.aws_region
  })

  tags = merge(local.tags, { Name = "${local.name_prefix}-monitoring-vm" })
}
