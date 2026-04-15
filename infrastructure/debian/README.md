# Monitoring (dedicated Debian VM)

This folder contains bootstrap/configuration assets used to run monitoring on a dedicated Debian machine outside Kubernetes.

## Current scope

- Grafana runs in Docker on the Debian VM.
- Prometheus runs in Docker on the Debian VM (internal target).
- `node-exporter` runs in Docker on the same VM to expose host metrics.
- Grafana auto-provisions a Prometheus datasource (defaults to the local Prometheus container).
- Grafana data is backed up to S3 on a cron schedule (if configured).

## Files

- `debian/bootstrap.sh.tftpl`: startup script rendered by Terraform (`infrastructure/terraform/monitoring_vm.tf`).

## Required Terraform variables

- `grafana_admin_user`
- `grafana_admin_password`

## Optional Terraform variables

- `monitoring_prometheus_url` (optional override for the Grafana Prometheus datasource URL)
- `monitoring_backup_s3_bucket`
- `monitoring_backup_cron`
