# Monitoring (dedicated Debian VM)

This folder contains bootstrap/configuration assets used to run monitoring on a dedicated Debian machine outside Kubernetes.

## Current scope

- Grafana runs in Docker on the Debian VM.
- Optional Prometheus datasource can be auto-provisioned.
- Grafana data is backed up to S3 on a cron schedule (if configured).

## Files

- `debian/bootstrap.sh.tftpl`: startup script rendered by Terraform (`infrastructure/terraform/monitoring_vm.tf`).

## Required Terraform variables

- `grafana_admin_user`
- `grafana_admin_password`

## Optional Terraform variables

- `monitoring_prometheus_url`
- `monitoring_backup_s3_bucket`
- `monitoring_backup_cron`
