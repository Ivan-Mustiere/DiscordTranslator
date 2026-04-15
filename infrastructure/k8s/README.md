# Kubernetes setup

This directory contains a pragmatic production-ready Kubernetes structure with:

- `base`: shared manifests for all environments
- `overlays/dev`: development customization
- `overlays/preprod`: pre-production customization
- `overlays/prod`: production customization

## Prerequisites

- A Kubernetes cluster (`kind`, `minikube`, or managed cluster)
- `kubectl`
- `kustomize` support in kubectl (v1.14+)
- NGINX ingress controller for ingress resources
- `metrics-server` for HPA

## 1) Create namespace and resources (dev)

Create your secret from the template first:

```bash
kubectl create namespace discord-translator-dev
kubectl -n discord-translator-dev create secret generic app-secrets \
  --from-literal=DISCORD_TOKEN=replace-me \
  --from-literal=DEEPL_API_KEY=replace-me \
  --from-literal=OPENAI_API_KEY=replace-me
kubectl -n discord-translator-dev create secret generic rundeck-auth \
  --from-literal=RUNDECK_ADMIN_USERNAME=admin \
  --from-literal=RUNDECK_ADMIN_PASSWORD=replace-me
```

Deploy:

```bash
kubectl apply -k infrastructure/k8s/overlays/dev
```

## 2) Create resources (preprod)

```bash
kubectl create namespace discord-translator-preprod
kubectl -n discord-translator-preprod create secret generic app-secrets \
  --from-literal=DISCORD_TOKEN=replace-me \
  --from-literal=DEEPL_API_KEY=replace-me \
  --from-literal=OPENAI_API_KEY=replace-me
kubectl -n discord-translator-preprod create secret generic rundeck-auth \
  --from-literal=RUNDECK_ADMIN_USERNAME=admin \
  --from-literal=RUNDECK_ADMIN_PASSWORD=replace-me
kubectl apply -k infrastructure/k8s/overlays/preprod
```

## 3) Create resources (prod)

```bash
kubectl create namespace discord-translator-prod
kubectl -n discord-translator-prod create secret generic app-secrets \
  --from-literal=DISCORD_TOKEN=replace-me \
  --from-literal=DEEPL_API_KEY=replace-me \
  --from-literal=OPENAI_API_KEY=replace-me
kubectl -n discord-translator-prod create secret generic rundeck-auth \
  --from-literal=RUNDECK_ADMIN_USERNAME=admin \
  --from-literal=RUNDECK_ADMIN_PASSWORD=replace-me
kubectl apply -k infrastructure/k8s/overlays/prod
```

## 4) Validate

```bash
kubectl get pods -n discord-translator-dev
kubectl get svc -n discord-translator-dev
kubectl get ingress -n discord-translator-dev
kubectl get hpa -n discord-translator-dev
```

Rundeck access host by environment:

- dev: `rundeck.dev.discordtranslator.local`
- preprod: `rundeck.preprod.discordtranslator.com`
- prod: `rundeck.discordtranslator.com`

## Notes

- Replace image names in manifests with your actual registry/repository.
- `secret.example.yaml` is a template and is intentionally not applied.
- If your FastAPI health route differs from `/health`, update probes in `base/fastapi-gateway.yaml`.
