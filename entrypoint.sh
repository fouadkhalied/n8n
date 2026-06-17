#!/bin/sh
set -e

# Import workflow once n8n DB tables are ready
import_workflow() {
  sleep 10
  if [ -f /workflow/whatsapp-shopify.json ]; then
    echo "[entrypoint] Importing workflow..."
    n8n import:workflow --input=/workflow/whatsapp-shopify.json \
      && echo "[entrypoint] Workflow imported successfully."
  fi
}

import_workflow &

exec n8n start