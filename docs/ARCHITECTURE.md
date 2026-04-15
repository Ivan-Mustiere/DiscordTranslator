# Architecture overview

## Service flow

1. `bot-discord` receives events/messages.
2. `fastapi-gateway` exposes API endpoints and orchestrates requests.
3. `asr-engine` handles speech-to-text/voice related processing.
4. `spark-processor` handles heavy data processing jobs.
5. `kafka-broker` is the event bus between services.
6. S3 stores data artifacts (`raw`, `processed`, `models`, `logs`).

## Deployment model

- Kubernetes is the runtime platform.
- Environment overlays:
  - `infrastructure/k8s/overlays/dev`
  - `infrastructure/k8s/overlays/preprod`
  - `infrastructure/k8s/overlays/prod`

## Delivery model

- Jenkins:
  - build images
  - push registry
  - update overlay tags in Git
- ArgoCD:
  - auto-sync overlays from Git to cluster

## Ops model

- Rundeck provides runbook execution.
- Rundeck is scoped with namespace RBAC (`rundeck-sa` + Role/RoleBinding).

## Infrastructure model

- Terraform provisions AWS resources (VPC, EKS, S3).
