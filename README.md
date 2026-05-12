<!-- markdownlint-disable MD033 MD041 -->
<p align="center">
  <img src="./.github/action-ccstudio-ide-sample_banner.png" alt="action-ccstudio-ide_banner" width="800" />
</p>

<p align="center">
  <img src="https://img.shields.io/github/v/release/uoohyo/action-ccstudio-ide?logo=github" alt="Latest Release" />
  <img src="https://img.shields.io/github/actions/workflow/status/uoohyo/action-ccstudio-ide-sample/test-all-versions.yml?branch=main&label=multi-version%20tests" alt="Build Status" />
  <img src="https://img.shields.io/badge/CCS%20Versions-48%2B-blue" alt="CCS Versions" />
  <img src="https://img.shields.io/badge/Device-TMS320F28335-orange" alt="Target Device" />
  <img src="https://img.shields.io/badge/License-MIT-green" alt="License" />
</p>

# Multi-Version CCS Build Testing

이 저장소는 [uoohyo/action-ccstudio-ide](https://github.com/marketplace/actions/build-with-code-composer-studio-integrated-development-environment-ide) GitHub Action의 **모든 릴리스 버전에 대한 포괄적인 호환성 테스트**를 제공합니다.

## 🎯 목적

Code Composer Studio(CCS)의 다양한 버전에서 action-ccstudio-ide가 정상적으로 작동하는지 자동으로 검증합니다. 새로운 CCS 버전이 릴리스되면 자동으로 테스트 프로젝트를 생성하고 빌드 테스트를 수행합니다.

## ✨ 주요 기능

- **자동 버전 발견**: GitHub Releases API를 통해 새 CCS 버전 자동 감지
- **프로젝트 자동 생성**: 누락된 버전의 테스트 프로젝트를 Docker + CCS CLI로 자동 생성
- **포괄적 테스트**: 48개 이상의 CCS 버전 커버 (v7.0.0 ~ v20.5.1)
- **지속적 통합**: main 브랜치 푸시 시 모든 버전 자동 빌드 테스트
- **실시간 상태 대시보드**: 아래 테이블에서 각 버전의 빌드 상태 확인 가능

## 🔧 타겟 구성

- **디바이스**: TMS320F28335 (C2000 family DSP)
- **제조사**: Texas Instruments Inc.
- **출력 형식**: COFF
- **빌드 구성**: Debug, Release
- **메모리 모드**: RAM 기반 (28335_RAM_lnk.cmd 사용)

## 📁 프로젝트 구조

```text
action-ccstudio-ide-sample/
├── .github/
│   ├── workflows/
│   │   └── test-all-versions.yml    # 메인 테스트 워크플로우
│   ├── scripts/
│   │   ├── discover-versions.sh     # 버전 발견
│   │   ├── generate-project.sh      # 프로젝트 생성
│   │   ├── save-test-result.sh      # 테스트 결과 저장
│   │   └── update-readme-table.sh   # README 업데이트
│   └── test-results/                # 테스트 결과 JSON 파일
├── projects/                         # CCS 프로젝트들
│   ├── f28335_v7.0.0.00043/
│   ├── f28335_v12.8.1.00005/
│   ├── f28335_v20.5.1.00012/
│   └── ...
└── templates/                        # 프로젝트 생성 템플릿
    ├── main.c
    └── 28335_RAM_lnk.cmd
```

<!-- TEST_RESULTS_START -->
<!-- 워크플로우 실행 후 여기에 테스트 결과 테이블이 자동 생성됩니다 -->
<!-- TEST_RESULTS_END -->

## 🚀 사용 방법

### 전체 테스트 실행

```bash
gh workflow run test-all-versions.yml
```

### 특정 버전 수동 테스트

```bash
# 1. 프로젝트 생성 (없는 경우)
bash .github/scripts/generate-project.sh "12.0.0.00009"

# 2. 워크플로우 트리거 (해당 버전만 빌드됨)
git add projects/
git commit -m "add: CCS v12.0.0.00009 project"
git push
```

## 🔄 워크플로우 동작 방식

1. **버전 발견**: GitHub Releases API로 action-ccstudio-ide의 모든 릴리스 조회
2. **갭 감지**: 기존 `./projects/` 폴더와 비교하여 누락된 버전 식별
3. **프로젝트 생성**: Docker 컨테이너에서 CCS CLI로 누락된 버전의 프로젝트 생성
4. **빌드 테스트**: Matrix 전략으로 모든 버전을 병렬 빌드 (Debug + Release)
5. **결과 저장**: 각 버전의 빌드 결과를 JSON 파일로 저장
6. **README 업데이트**: 테스트 결과 테이블을 자동으로 갱신

## 🤝 기여하기

새로운 CCS 버전 지원을 추가하려면:

1. `uoohyo/action-ccstudio-ide`에서 해당 버전이 릴리스되었는지 확인
2. main 브랜치에 푸시 → 시스템이 자동으로 프로젝트 생성 및 테스트
3. 또는 수동으로 프로젝트 생성: `bash .github/scripts/generate-project.sh "X.X.X.XXXXX"`

## 📊 테스트 일정

- **자동 트리거**: main 브랜치 푸시 시
- **주기적 테스트**: 매주 월요일 오전 9시(KST)
- **수동 실행**: GitHub Actions 탭에서 언제든지 가능

## 📝 라이선스

[MIT License](./LICENSE)

Copyright (c) 2024-2026 [uoohyo](https://github.com/uoohyo)

---

<p align="center">
  Made with ❤️ for Code Composer Studio developers
</p>
