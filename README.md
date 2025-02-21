# Android-CMake-VSCode-Sample

Example project for creating native-activity C++ apps using Visual Studio Code for code editing and debugging.

## Features

- Android
- Native-activity app
- LLDB-Debugging
- VSCode (No Android Studio)
- C++
- CMake
- Gradle

## Prerequisites

- [Visual Studio Code](https://code.visualstudio.com/download) or [Codium](https://vscodium.com/#install)
- [Scoop](https://scoop.sh/)

Scoop Powershell Quickstart
```
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
Invoke-RestMethod -Uri https://get.scoop.sh | Invoke-Expression
```

## Set Up

- Right click `setup.ps1`, then `Run with PowerShell`
- Script installs
    - Gradle
    - Java Development Kit 17 (jdk)
    - Android SDK (Android Command Line Tool)
    - LLDB native debugger extension for VSCode
    - Android Debug extension for VSCode

## Getting Started

- In Visual Studio select `Run and Debug` option or `Ctrl+Shift+D`
- Execute `Android Debug and Launch`
