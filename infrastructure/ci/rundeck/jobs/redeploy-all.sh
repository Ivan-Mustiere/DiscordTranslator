#!/usr/bin/env bash
set -euo pipefail

NAMESPACE="${1:-}"

if [[ -z "${NAMESPACE}" ]]; then
  echo "Usage: $0 <namespace>"
  exit 1
fi

echo "Restarting workloads in namespace: ${NAMESPACE}"

kubectl -n "${NAMESPACE}" rollout restart deployment fastapi-gateway
kubectl -n "${NAMESPACE}" rollout restart deployment bot-discord
kubectl -n "${NAMESPACE}" rollout restart deployment asr-engine
kubectl -n "${NAMESPACE}" rollout restart deployment spark-processor
kubectl -n "${NAMESPACE}" rollout restart deployment kafka-broker

echo "Waiting for rollout completion..."
kubectl -n "${NAMESPACE}" rollout status deployment/fastapi-gateway --timeout=300s
kubectl -n "${NAMESPACE}" rollout status deployment/bot-discord --timeout=300s
kubectl -n "${NAMESPACE}" rollout status deployment/asr-engine --timeout=300s
kubectl -n "${NAMESPACE}" rollout status deployment/spark-processor --timeout=300s
kubectl -n "${NAMESPACE}" rollout status deployment/kafka-broker --timeout=300s

echo "All deployments restarted successfully."
