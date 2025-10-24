#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"

API_KEY="${THESYS_API_KEY:-}"
if [[ -z "$API_KEY" ]]; then
  echo "Error: THESYS_API_KEY environment variable is not set."
  echo "Set it in GitHub Actions secrets or export it locally before running."
  exit 1
fi

ROUTE_FILE="$ROOT_DIR/src/app/api/ask/route.ts"
if [[ ! -f "$ROUTE_FILE" ]]; then
  echo "Error: route file not found at $ROUTE_FILE"
  exit 1
fi

# Extract the model string from route.ts
MODEL=$(grep -E 'model:\s*"' "$ROUTE_FILE" | sed -E 's/.*model:\s*"([^"]+)".*/\1/' | head -n1)

if [[ -z "$MODEL" ]]; then
  echo "Error: Could not extract model from $ROUTE_FILE"
  exit 1
fi

echo "Found model in route.ts => $MODEL"
echo "Fetching list of valid models from Thesys..."

# Query Thesys API for available models
# NOTE: Endpoint may differ; adjust if Thesys docs specify a different path.
RESPONSE=$(curl -sS -H "Authorization: Bearer $API_KEY" https://api.thesys.dev/v1/models || true)

if [[ -z "$RESPONSE" ]]; then
  echo "Error: Empty response from Thesys API."
  exit 1
fi

# Try to parse JSON and look for 'id' fields. jq is commonly available on GitHub runners.
if command -v jq >/dev/null 2>&1; then
  # Extract all model IDs
  IDS=$(echo "$RESPONSE" | jq -r '.. | objects | .id? // empty')
  if echo "$IDS" | grep -Fxq "$MODEL"; then
    echo "Model '$MODEL' is valid ✅"
    exit 0
  else
    echo "Model '$MODEL' not found among available Thesys models."
    echo "Available IDs (subset):"
    echo "$IDS" | head -n 20
    exit 1
  fi
else
  # Fallback: simple grep for the model string in the raw response
  if echo "$RESPONSE" | grep -Fq "$MODEL"; then
    echo "Model '$MODEL' appears in Thesys response (no jq) ✅"
    exit 0
  else
    echo "Model '$MODEL' not found in Thesys response (no jq)."
    exit 1
  fi
fi