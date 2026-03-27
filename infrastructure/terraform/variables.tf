variable "project_name" {
  description = "Project name used for resource naming."
  type        = string
  default     = "discordtranslator"
}

variable "environment" {
  description = "Deployment environment: dev, preprod, prod."
  type        = string
}

variable "aws_region" {
  description = "AWS region."
  type        = string
  default     = "eu-west-3"
}

variable "eks_cluster_version" {
  description = "Kubernetes version for EKS cluster."
  type        = string
  default     = "1.30"
}

variable "node_group_instance_types" {
  description = "EKS managed node group instance types."
  type        = list(string)
  default     = ["t3.medium"]
}

variable "node_group_min_size" {
  description = "Minimum nodes in EKS node group."
  type        = number
  default     = 1
}

variable "node_group_max_size" {
  description = "Maximum nodes in EKS node group."
  type        = number
  default     = 3
}

variable "node_group_desired_size" {
  description = "Desired nodes in EKS node group."
  type        = number
  default     = 2
}

variable "vpc_cidr" {
  description = "VPC CIDR block."
  type        = string
  default     = "10.0.0.0/16"
}

variable "public_subnet_cidrs" {
  description = "Public subnet CIDRs."
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
}

variable "private_subnet_cidrs" {
  description = "Private subnet CIDRs."
  type        = list(string)
  default     = ["10.0.11.0/24", "10.0.12.0/24", "10.0.13.0/24"]
}

variable "s3_buckets" {
  description = "S3 buckets used by the app."
  type        = map(string)
}

variable "additional_tags" {
  description = "Additional tags applied to resources."
  type        = map(string)
  default     = {}
}

variable "db_name" {
  description = "Primary PostgreSQL database name."
  type        = string
  default     = "discordtranslator"
}

variable "db_username" {
  description = "Master username for PostgreSQL."
  type        = string
  default     = "app_admin"
}

variable "db_password" {
  description = "Master password for PostgreSQL."
  type        = string
  sensitive   = true
}

variable "db_instance_class" {
  description = "RDS instance class."
  type        = string
  default     = "db.t4g.medium"
}

variable "db_allocated_storage" {
  description = "Initial RDS allocated storage in GiB."
  type        = number
  default     = 20
}

variable "db_max_allocated_storage" {
  description = "Maximum autoscaled RDS storage in GiB."
  type        = number
  default     = 100
}

variable "db_engine_version" {
  description = "PostgreSQL engine version."
  type        = string
  default     = "16.3"
}

variable "db_multi_az" {
  description = "Enable Multi-AZ deployment for RDS."
  type        = bool
  default     = false
}

variable "db_backup_retention_period" {
  description = "Automated backup retention in days (0-35)."
  type        = number
  default     = 7
}

variable "db_backup_window" {
  description = "Preferred backup window in UTC (hh24:mi-hh24:mi)."
  type        = string
  default     = "03:00-04:00"
}

variable "db_maintenance_window" {
  description = "Preferred maintenance window in UTC."
  type        = string
  default     = "sun:04:00-sun:05:00"
}

variable "db_deletion_protection" {
  description = "Enable deletion protection on RDS instance."
  type        = bool
  default     = true
}

variable "db_skip_final_snapshot" {
  description = "Skip final snapshot on destroy."
  type        = bool
  default     = false
}

variable "monitoring_enabled" {
  description = "Enable dedicated monitoring Debian VM."
  type        = bool
  default     = true
}

variable "monitoring_instance_type" {
  description = "EC2 instance type for monitoring VM."
  type        = string
  default     = "t3.small"
}

variable "monitoring_root_volume_size" {
  description = "Root EBS volume size in GiB for monitoring VM."
  type        = number
  default     = 30
}

variable "monitoring_allowed_cidrs" {
  description = "CIDR blocks allowed to access Grafana (port 3000)."
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

variable "monitoring_ssh_allowed_cidrs" {
  description = "CIDR blocks allowed to SSH to monitoring VM (port 22)."
  type        = list(string)
  default     = []
}

variable "monitoring_key_name" {
  description = "Optional EC2 key pair name for SSH access to monitoring VM."
  type        = string
  default     = null
}

variable "grafana_admin_user" {
  description = "Grafana admin user on monitoring VM."
  type        = string
  default     = "admin"
}

variable "grafana_admin_password" {
  description = "Grafana admin password on monitoring VM."
  type        = string
  sensitive   = true
}

variable "monitoring_prometheus_url" {
  description = "Optional Prometheus URL override for the Grafana datasource (defaults to the local Prometheus container)."
  type        = string
  default     = ""
}

variable "monitoring_backup_s3_bucket" {
  description = "Optional S3 bucket used by Debian VM to store Grafana backups."
  type        = string
  default     = null
}

variable "monitoring_backup_cron" {
  description = "Cron schedule for Grafana backup job on Debian VM."
  type        = string
  default     = "0 2 * * *"
}
