#!/usr/bin/env bash
set -euo pipefail

REGISTRY="${1:?registry required}"
TAG="${2:?tag required}"
SERVICES="${3:?services required}"

for service in ${SERVICES}; do
  echo "Building ${REGISTRY}/discordtranslator-${service}:${TAG}"
  docker build -t "${REGISTRY}/discordtranslator-${service}:${TAG}" "services/${service}"
done
