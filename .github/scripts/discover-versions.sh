#!/bin/bash
set -euo pipefail

echo "Fetching releases from uoohyo/action-ccstudio-ide..."

# GitHub Releases API로 모든 버전 가져오기
gh api repos/uoohyo/action-ccstudio-ide/releases \
  --paginate \
  --jq '.[].tag_name' \
  | grep -E '^v[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+$' \
  | sed 's/^v//' \
  | sort -V > /tmp/all_versions.txt

echo "Scanning existing projects..."
ls projects/ 2>/dev/null \
  | grep '^f28335_v' \
  | sed 's/f28335_v//' \
  | sort -V > /tmp/existing_versions.txt || touch /tmp/existing_versions.txt

echo "Finding missing versions..."
comm -23 /tmp/all_versions.txt /tmp/existing_versions.txt > /tmp/missing_versions.txt

MISSING_COUNT=$(wc -l < /tmp/missing_versions.txt)
TOTAL_COUNT=$(wc -l < /tmp/all_versions.txt)

echo "Total versions: $TOTAL_COUNT"
echo "Existing versions: $(wc -l < /tmp/existing_versions.txt)"
echo "Missing versions: $MISSING_COUNT"

if [ "$MISSING_COUNT" -gt 0 ]; then
  echo "Missing versions:"
  cat /tmp/missing_versions.txt
fi

# GitHub Actions output으로 내보내기
{
  echo "all_versions<<EOF"
  cat /tmp/all_versions.txt
  echo "EOF"
  echo "missing_versions<<EOF"
  cat /tmp/missing_versions.txt
  echo "EOF"
  echo "missing_count=$MISSING_COUNT"
} >> "$GITHUB_OUTPUT"
