#!/usr/bin/env bash

set -u

echo "==> Checking documentation Terraform blocks are formatted..."

error=false

while IFS= read -r -d '' f; do
  echo "Checking: $f"

  if ! terrafmt diff -c -q "$f"; then
    error=true
  fi
done < <(
  find . \
    -type f \
    \( -name "*.md" -o -name "*.go" \) \
    -not -path "./.github/*" \
    -not -path "*/vendor/*" \
    -not -path "*/.terraform/*" \
    -not -name "*-terraform"
    -print0
)

if [[ "$error" == "true" ]]; then
  echo "------------------------------------------------"
  echo ""
  echo "The preceding files contain Terraform blocks that are"
  echo "not correctly formatted or contain errors."
  echo ""
  echo "You can fix this by running:"
  echo ""
  echo "  make tools"
  echo "  make terrafmt"
  echo ""
  exit 1
fi

echo "==> All Terraform blocks are correctly formatted."
exit 0
