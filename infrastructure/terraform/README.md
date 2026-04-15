# Terraform AWS foundation

This folder provisions a pragmatic AWS foundation for the project:

- VPC (public/private subnets + NAT)
- EKS cluster with managed node group
- S3 buckets for data, models, and logs
- RDS PostgreSQL in private subnets with automated backups
- Dedicated Debian EC2 VM for Grafana + Prometheus monitoring

## Files

- `versions.tf`: Terraform and provider versions
- `variables.tf`: Input variables
- `main.tf`: AWS provider, locals, EKS module
- `vpc.tf`: VPC module
- `s3.tf`: S3 buckets + security defaults
- `rds.tf`: RDS PostgreSQL (subnet group, security group, instance)
- `monitoring_vm.tf`: Debian VM with Docker + Grafana
- `outputs.tf`: Useful outputs
- `terraform.tfvars.example`: Example environment values

## Usage

1. Copy vars file:

```bash
cp terraform.tfvars.example terraform.tfvars
```

2. Update values for `dev`, `preprod`, or `prod`.

3. Run Terraform:

```bash
terraform init
terraform plan
terraform apply
```

## Environment strategy

Use one vars file per environment:

- `dev.tfvars`
- `preprod.tfvars`
- `prod.tfvars`

Example:

```bash
terraform plan -var-file=preprod.tfvars
terraform apply -var-file=preprod.tfvars
```

## PostgreSQL notes

- Database is private (no public IP) and reachable from EKS nodes on port `5432`.
- Backups are managed by RDS (`db_backup_retention_period` + point-in-time restore).
- Keep `db_deletion_protection = true` in preprod/prod.
- Set a strong `db_password` in your real `*.tfvars` file (never commit secrets).

## Monitoring VM notes

- Grafana runs on a dedicated Debian VM (outside Kubernetes) on port `3000`.
- Restrict `monitoring_allowed_cidrs` to trusted office/VPN ranges.
- Set `monitoring_ssh_allowed_cidrs` and `monitoring_key_name` if SSH access is needed.
- Set a strong `grafana_admin_password` in your real `*.tfvars` file (never commit secrets).
- Grafana auto-provisions a Prometheus datasource (defaults to the local Prometheus container).
- Optional datasource override can be set through `monitoring_prometheus_url`.
- If `monitoring_backup_s3_bucket` is set, the VM gets IAM write access and sends Grafana backups to S3 on `monitoring_backup_cron`.
- Bootstrap script used by Terraform is located in `monitoring/debian/bootstrap.sh.tftpl`.
