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

This repository provides **comprehensive compatibility testing** for the [uoohyo/action-ccstudio-ide](https://github.com/marketplace/actions/build-with-code-composer-studio-integrated-development-environment-ide) GitHub Action across all released versions.

## 🎯 Purpose

Automatically verify that action-ccstudio-ide works correctly across various versions of Code Composer Studio (CCS). When new CCS versions are released, test projects are automatically generated and build tests are performed.

## ✨ Key Features

- **Automated Version Discovery**: Automatically detect new CCS versions via GitHub Releases API
- **Auto-Generate Projects**: Automatically create test projects for missing versions using Docker + CCS CLI
- **Comprehensive Testing**: Coverage of 48+ CCS versions (v7.0.0 ~ v20.5.1)
- **Continuous Integration**: Automatic build testing for all versions on push to main branch
- **Real-Time Status Dashboard**: Check build status for each version in the table below

## 🔧 Target Configuration

- **Device**: TMS320F28335 (C2000 family DSP)
- **Manufacturer**: Texas Instruments Inc.
- **Output Format**: COFF
- **Build Configurations**: Debug, Release
- **Memory Mode**: RAM-based (using 28335_RAM_lnk.cmd)

## 📁 Project Structure

```text
action-ccstudio-ide-sample/
├── .github/
│   ├── workflows/
│   │   └── test-all-versions.yml    # Main test workflow
│   ├── scripts/
│   │   ├── discover-versions.sh     # Version discovery
│   │   ├── generate-project.sh      # Project generation
│   │   ├── save-test-result.sh      # Test result storage
│   │   └── update-readme-table.sh   # README updater
│   └── test-results/                # Test result JSON files
├── projects/                         # CCS projects
│   ├── f28335_v7.0.0.00043/
│   ├── f28335_v12.8.1.00005/
│   ├── f28335_v20.5.1.00012/
│   └── ...
└── templates/                        # Project generation templates
    ├── main.c
    └── 28335_RAM_lnk.cmd
```

<!-- TEST_RESULTS_START -->
<!-- Test results table will be auto-generated here after workflow execution -->
<!-- TEST_RESULTS_END -->

## 🚀 Usage

### Run All Tests

```bash
gh workflow run test-all-versions.yml
```

### Manual Test for Specific Version

```bash
# 1. Generate project (if not exists)
bash .github/scripts/generate-project.sh "12.0.0.00009"

# 2. Trigger workflow (builds only that version)
git add projects/
git commit -m "add: CCS v12.0.0.00009 project"
git push
```

## 🔄 How It Works

1. **Version Discovery**: Query all releases from action-ccstudio-ide via GitHub Releases API
2. **Gap Detection**: Compare with existing `./projects/` folder to identify missing versions
3. **Project Generation**: Create projects for missing versions using CCS CLI in Docker containers
4. **Build Testing**: Parallel builds for all versions using matrix strategy (Debug + Release)
5. **Result Storage**: Save build results for each version as JSON files
6. **README Update**: Automatically update test results table

## 🤝 Contributing

To add support for a new CCS version:

1. Verify the version is released in `uoohyo/action-ccstudio-ide`
2. Push to main branch → System automatically generates project and runs tests
3. Or manually generate project: `bash .github/scripts/generate-project.sh "X.X.X.XXXXX"`

## 📊 Test Schedule

- **Automatic Trigger**: On push to main branch
- **Periodic Testing**: Every Monday at 9 AM KST
- **Manual Execution**: Anytime from GitHub Actions tab

## 📝 License

[MIT License](./LICENSE)

Copyright (c) 2024-2026 [uoohyo](https://github.com/uoohyo)

---

<p align="center">
  Made with ❤️ for Code Composer Studio developers
</p>
