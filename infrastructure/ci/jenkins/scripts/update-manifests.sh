#!/usr/bin/env bash
set -euo pipefail

OVERLAY_FILE="${1:?overlay file required}"
TAG="${2:?tag required}"
SERVICES="${3:?services required}"

if [[ ! -f "${OVERLAY_FILE}" ]]; then
  echo "Overlay file not found: ${OVERLAY_FILE}"
  exit 1
fi

for service in ${SERVICES}; do
  sed -i -E "s#(discordtranslator-${service}:)[A-Za-z0-9._-]+#\\1${TAG}#g" "${OVERLAY_FILE}"
done

echo "Updated image tags in ${OVERLAY_FILE}"
