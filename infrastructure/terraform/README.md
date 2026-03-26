# Terraform AWS foundation

This folder provisions a pragmatic AWS foundation for the project:

- VPC (public/private subnets + NAT)
- EKS cluster with managed node group
- S3 buckets for data, models, and logs

## Files

- `versions.tf`: Terraform and provider versions
- `variables.tf`: Input variables
- `main.tf`: AWS provider, locals, EKS module
- `vpc.tf`: VPC module
- `s3.tf`: S3 buckets + security defaults
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
