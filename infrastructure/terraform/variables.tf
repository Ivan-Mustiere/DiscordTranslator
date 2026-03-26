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
