#!/usr/bin/env bash
set -euo pipefail

REGISTRY="${1:?registry required}"
TAG="${2:?tag required}"
SERVICES="${3:?services required}"
REGISTRY_USER="${4:?registry user required}"
REGISTRY_TOKEN="${5:?registry token required}"

echo "${REGISTRY_TOKEN}" | docker login "${REGISTRY}" -u "${REGISTRY_USER}" --password-stdin

for service in ${SERVICES}; do
  echo "Pushing ${REGISTRY}/discordtranslator-${service}:${TAG}"
  docker push "${REGISTRY}/discordtranslator-${service}:${TAG}"
done
