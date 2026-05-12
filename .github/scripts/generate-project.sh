#!/bin/bash
set -euo pipefail

VERSION=$1
PROJECT_NAME="f28335_v${VERSION}"
PROJECT_DIR="projects/${PROJECT_NAME}"

echo "=== Generating project: $PROJECT_NAME ==="

# Docker 이미지 pull
echo "Pulling Docker image: uoohyo/ccstudio-ide:${VERSION}"
docker pull "uoohyo/ccstudio-ide:${VERSION}"

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
  "

# main.c와 linker script 복사
echo "Copying template files..."
cp templates/main.c "${PROJECT_DIR}/"
cp templates/28335_RAM_lnk.cmd "${PROJECT_DIR}/"

# .ccsproject 버전 정보 업데이트
if [ -f "${PROJECT_DIR}/.ccsproject" ]; then
  echo "Updating version information in .ccsproject..."
  IFS='.' read -r MAJOR MINOR PATCH BUILD <<< "$VERSION"
  sed -i "s/value=\"[0-9]*\.[0-9]*\"/value=\"${MAJOR}.${MINOR}\"/g" "${PROJECT_DIR}/.ccsproject"
fi

echo "✅ Project generated: ${PROJECT_DIR}"
ls -la "${PROJECT_DIR}"
