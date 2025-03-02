# Android-CMake-VSCode-Sample

Example project for creating native android apps (C++ Only) using Visual Studio Code for code editing and debugging. Support for Address and Undefined Behavior Sanatizers.

## Features

- Develop Android Native Activity Apps (No Java/Kotlin)
- Sanatizer Support : ASAN, HWASAN and UBSAN
- Support for latest SDK and NDK
- LLDB-Debugging
- VSCode (No Android Studio)
- C++
- CMake
- Gradle
- Easy Set Up + Installer Script
- USB Debugging

## Prerequisites

- [Visual Studio Code](https://code.visualstudio.com/download) or [Codium](https://vscodium.com/#install)
- Windows 10/11
- [Scoop](https://scoop.sh/)

Scoop Powershell Quickstart
```
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
Invoke-RestMethod -Uri https://get.scoop.sh | Invoke-Expression
```

## Set Up Project

- Right click `setup.ps1`, then `Run with PowerShell`
- Script installs
    - Gradle
    - Java Development Kit 17 (jdk)
    - Android Command Line Tool
        - Installs appropriate SDK, NDK, ADB and CMAKE
    - LLDB native debugger extension for VSCode
    - Android Debug extension for VSCode

## Setup USB Debugging for Android Devices

### Method 1:

- Download the compatible device USB driver (search online for device name + usb driver)
- Unzip the file to any location on your PC
- Double click on the .exe file
- Follow the instructions
- Click finish
- You can select now your usb connected device inside visual studio as target

### Method 2:

- Download the compatible device USB driver (search online for device name + usb driver)
- Unzip the file to any location on your PC
- Open the device manager and click on your computer
- On the top left click action -> add legacy hardware
- Select Install the hardware that I manually select from a list
- Select All devices
- Select Have Disk and set the path to your .inf file inside your extracted driver file
- Select Install the downloaded driver file
- Follow the remaining instructions and restart your pc
- You can select now your usb connected device inside visual studio as target

## Getting Started

- In Visual Studio select `Run and Debug` option or `Ctrl+Shift+D`
- Execute `Android Debug and Launch`
    - Select Target Device (USB-Debugging must be enabled)
    - Choose Build Configuration
- Debugging starts automatically after Build has finished



## Signing apks for realease builds

* An example keystore is part of this project to sign the Release version of the App
* Please generate your own keystore for production
* More Info :
    * [Create keystore](https://stackoverflow.com/questions/3997748/how-can-i-create-a-keystore)
    * [Setup gradle to automatically sign apk](https://developer.android.com/studio/build/building-cmdline)

## Troubleshooting installation errors

### Unknown Error Code on Installation

```
The package manager failed to install the apk: '/data/local/tmp/NativeAndroidActivity.apk' with the error code: 'Unknown'
```

Multiple possible reasons can cause this error. Common Fix :  Old installed APK under the same name is incompatible with the new build APK. Try to delete the old APK before installing the new one.

For more details about the error execute:

```
.\adb.exe install app-<configuration>.apk
```





