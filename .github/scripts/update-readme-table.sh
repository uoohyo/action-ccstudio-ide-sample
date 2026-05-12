#!/bin/bash
set -euo pipefail

REPO="${GITHUB_REPOSITORY:-uoohyo/action-ccstudio-ide-sample}"
WORKFLOW_URL="https://github.com/${REPO}/actions/workflows/test-all-versions.yml"

# 테이블 헤더 생성
TABLE=$(cat <<'EOF'
<!-- TEST_RESULTS_START -->

## Test Results

This table shows the build status for all tested CCS versions:

| CCS Version | Build Status | Configurations | Last Updated | Details |
|-------------|-------------|----------------|--------------|---------|
EOF
)

# 각 버전에 대한 행 추가
for dir in projects/f28335_v*; do
  VERSION=$(basename "$dir" | sed 's/f28335_v//')
  RESULT_FILE=".github/test-results/${VERSION}.json"

  if [ -f "$RESULT_FILE" ]; then
    # 결과 파일에서 정보 추출
    STATUS=$(jq -r '.status' "$RESULT_FILE")
    TIMESTAMP=$(jq -r '.timestamp' "$RESULT_FILE")
    LOG_URL=$(jq -r '.log_url' "$RESULT_FILE")

    # 상태에 따른 배지 색상
    if [ "$STATUS" = "success" ]; then
      BADGE_COLOR="brightgreen"
      BADGE_MESSAGE="passing"
    else
      BADGE_COLOR="red"
      BADGE_MESSAGE="failing"
    fi

    # shields.io 배지 URL
    BADGE_URL="https://img.shields.io/badge/build-${BADGE_MESSAGE}-${BADGE_COLOR}"

    # 날짜 포맷팅
    FORMATTED_DATE=$(date -d "$TIMESTAMP" "+%Y-%m-%d")

    # 테이블 행 추가
    TABLE+="
| v${VERSION} | ![Build Status](${BADGE_URL}) | Debug, Release | ${FORMATTED_DATE} | [Logs](${LOG_URL}) |"
  else
    # 결과 파일이 없으면 미테스트 상태
    BADGE_URL="https://img.shields.io/badge/build-pending-yellow"
    TABLE+="
| v${VERSION} | ![Build Status](${BADGE_URL}) | Debug, Release | - | [Workflow](${WORKFLOW_URL}) |"
  fi
done

# 테이블 마커 종료
TABLE+="

<!-- TEST_RESULTS_END -->"

# README.md 업데이트
if grep -q "<!-- TEST_RESULTS_START -->" README.md; then
  # 기존 섹션 교체
  awk -v table="$TABLE" '
    /<!-- TEST_RESULTS_START -->/ {
      print table
      skip=1
      next
    }
    /<!-- TEST_RESULTS_END -->/ {
      skip=0
      next
    }
    !skip
  ' README.md > README.md.tmp
  mv README.md.tmp README.md
else
  # README 끝에 추가
  echo "" >> README.md
  echo "$TABLE" >> README.md
fi

echo "✅ README.md updated successfully"
