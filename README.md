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
<!-- markdownlint-enable MD033 MD041 -->

<!-- TEST_RESULTS_START -->
<!-- Test results table will be auto-generated here after workflow execution -->
<!-- TEST_RESULTS_END -->

This repository provides **comprehensive compatibility testing** for the [uoohyo/action-ccstudio-ide](https://github.com/marketplace/actions/build-with-code-composer-studio-integrated-development-environment-ide) GitHub Action across all released versions.

## Purpose

Automatically verify that action-ccstudio-ide works correctly across various versions of Code Composer Studio (CCS). When new CCS versions are released, test projects are automatically generated and build tests are performed.

## Key Features

- **Automated Version Discovery**: Automatically detect new CCS versions via GitHub Releases API
- **Auto-Generate Projects**: Automatically create test projects for missing versions using Docker + CCS CLI
- **Comprehensive Testing**: Coverage of 48+ CCS versions (v7.0.0 ~ v20.5.1)
- **Continuous Integration**: Automatic build testing for all versions on push to main branch
- **Real-Time Status Dashboard**: Check build status for each version in the table below

## Target Configuration

- **Device**: TMS320F28335 (C2000 family DSP)
- **Manufacturer**: Texas Instruments Inc.
- **Output Format**: COFF
- **Build Configurations**: Debug, Release
- **Memory Mode**: RAM-based (using 28335_RAM_lnk.cmd)

## License

[MIT License](./LICENSE)

Copyright (c) 2024-2026 [uoohyo](https://github.com/uoohyo)

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
