# Jenkins pipeline

This pipeline builds images, pushes them to the registry, updates Kubernetes overlays, and pushes a Git commit to trigger ArgoCD sync.

## Required Jenkins credentials

- `ghcr-creds` (Username/Password)
  - username: GitHub username
  - password: GitHub token with package write access

## Required Jenkins tools on agent

- Docker CLI + daemon
- Git
- Bash

## Pipeline parameters

- `TARGET_ENV`: `dev`, `preprod`, `prod`
- `IMAGE_TAG`: optional override (auto-generated if empty)
- `PUSH_IMAGES`: push images to registry
- `UPDATE_MANIFESTS`: update K8s overlay files and push commit

## Behavior

- `dev` and `preprod`: tags updated in `infrastructure/k8s/overlays/<env>/patches.yaml`
- `prod`: tags updated in `infrastructure/k8s/overlays/prod/images.yaml`
- For `prod`, pipeline requires manual approval before image build.

## Job setup checklist

1. Create a Pipeline job and point it to `cicd/jenkins/Jenkinsfile`
2. Add credential `ghcr-creds`
3. Allow job to push to repository branch
4. (Optional) Add webhook trigger from Git provider
5. Run first build on `dev`
