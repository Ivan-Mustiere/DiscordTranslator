# Rundeck operations

This folder contains starter assets for Rundeck jobs.

## Suggested jobs

- `redeploy-all`: restart all application deployments in a target namespace
- `restart-service`: restart only one deployment
- `scale-service`: temporary scale up/down for incident handling

## Prerequisites

- Rundeck deployed in Kubernetes (`infrastructure/k8s/base/rundeck.yaml`)
- A Kubernetes ServiceAccount token or kubeconfig mounted in Rundeck
- `kubectl` available in the Rundeck execution context

## Example

Run `jobs/redeploy-all.sh` with one argument:

```bash
./jobs/redeploy-all.sh discord-translator-preprod
```
