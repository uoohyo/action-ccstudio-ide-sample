#!/bin/bash
set -euo pipefail

VERSION=$1
PROJECT_NAME="f28335_v${VERSION}"
PROJECT_DIR="projects/${PROJECT_NAME}"

echo "=== Generating project: $PROJECT_NAME ==="

# Docker 이미지 존재 확인
if ! docker pull "uoohyo/ccstudio-ide:${VERSION}" 2>/dev/null; then
  echo "❌ Docker image not found: uoohyo/ccstudio-ide:${VERSION}"
  echo "   Skipping project generation for this version"
  exit 0
fi

# 프로젝트 디렉토리 생성
mkdir -p "$PROJECT_DIR"

# Docker로 CCS 프로젝트 생성
echo "Creating CCS project using Docker..."
docker run --rm \
  -v "$(pwd):/workspace" \
  -w /workspace \
  "uoohyo/ccstudio-ide:${VERSION}" \
  bash -c "
    # CCS CLI로 프로젝트 생성
    /opt/ti/ccs/eclipse/eclipse \
      -noSplash \
      -data /tmp/workspace \
      -application com.ti.ccstudio.apps.projectCreate \
      -ccs.name ${PROJECT_NAME} \
      -ccs.device TMS320F28335 \
      -ccs.outputFormat COFF \
      -ccs.endianness little \
      -ccs.kind executable \
      -ccs.cgtVersion AUTO \
      -ccs.location /workspace/${PROJECT_DIR}
  " || {
    echo "⚠️  CCS CLI failed, falling back to template-based generation"

    # Fallback: 템플릿 기반 생성
    # 가장 가까운 버전 찾기
    MAJOR_VERSION=$(echo "$VERSION" | cut -d. -f1)
    CLOSEST_VERSION=$(ls projects/ | grep "^f28335_v${MAJOR_VERSION}\." | head -1 | sed 's/f28335_v//')

    if [ -z "$CLOSEST_VERSION" ]; then
      # 메이저 버전이 없으면 전체에서 가장 가까운 버전 찾기
      CLOSEST_VERSION=$(ls projects/ | grep '^f28335_v' | head -1 | sed 's/f28335_v//')
    fi

    echo "Using template from v${CLOSEST_VERSION}"
    cp -r "projects/f28335_v${CLOSEST_VERSION}"/* "${PROJECT_DIR}/"

    # 프로젝트 이름 변경
    sed -i "s/f28335_v${CLOSEST_VERSION}/${PROJECT_NAME}/g" "${PROJECT_DIR}/.project" || \
      sed -i "" "s/f28335_v${CLOSEST_VERSION}/${PROJECT_NAME}/g" "${PROJECT_DIR}/.project"
  }

# main.c와 linker script 복사
cp templates/main.c "${PROJECT_DIR}/"
cp templates/28335_RAM_lnk.cmd "${PROJECT_DIR}/" || true

# .ccsproject 버전 정보 업데이트 (Docker가 생성한 경우)
if [ -f "${PROJECT_DIR}/.ccsproject" ]; then
  # 버전 정보 추출
  IFS='.' read -r MAJOR MINOR PATCH BUILD <<< "$VERSION"

  # XML에서 버전 업데이트
  sed -i "s/value=\"[0-9]*\.[0-9]*\"/value=\"${MAJOR}.${MINOR}\"/g" "${PROJECT_DIR}/.ccsproject" || \
    sed -i "" "s/value=\"[0-9]*\.[0-9]*\"/value=\"${MAJOR}.${MINOR}\"/g" "${PROJECT_DIR}/.ccsproject"
fi

echo "✅ Project generated: ${PROJECT_DIR}"
ls -la "${PROJECT_DIR}"
