output "aws_account_id" {
  description = "AWS account ID used by Terraform."
  value       = data.aws_caller_identity.current.account_id
}

output "eks_cluster_name" {
  description = "EKS cluster name."
  value       = module.eks.cluster_name
}

output "eks_cluster_endpoint" {
  description = "EKS cluster API endpoint."
  value       = module.eks.cluster_endpoint
}

output "vpc_id" {
  description = "VPC ID."
  value       = module.vpc.vpc_id
}

output "private_subnets" {
  description = "Private subnet IDs."
  value       = module.vpc.private_subnets
}

output "s3_bucket_names" {
  description = "S3 bucket names created for the app."
  value       = [for bucket in aws_s3_bucket.app : bucket.bucket]
}

output "rds_postgres_endpoint" {
  description = "RDS PostgreSQL endpoint hostname."
  value       = aws_db_instance.postgres.address
}

output "rds_postgres_port" {
  description = "RDS PostgreSQL port."
  value       = aws_db_instance.postgres.port
}

output "rds_postgres_db_name" {
  description = "RDS PostgreSQL database name."
  value       = aws_db_instance.postgres.db_name
}

output "monitoring_vm_public_ip" {
  description = "Public IP of dedicated monitoring Debian VM."
  value       = try(aws_instance.monitoring_vm[0].public_ip, null)
}

output "monitoring_vm_public_dns" {
  description = "Public DNS of dedicated monitoring Debian VM."
  value       = try(aws_instance.monitoring_vm[0].public_dns, null)
}

output "monitoring_backup_s3_bucket" {
  description = "S3 bucket used by monitoring VM for Grafana backups."
  value       = var.monitoring_backup_s3_bucket
}
