# XcodeAnyDebugRootless

![20241008172148](README.assets/20241008172148.jpg)

## 简介

 XcodeAnyDebugRootless 让你能够使用 Xcode 调试任意 iOS 应用。基于 Dopamine 越狱环境开发,提供安全稳定的调试体验。

## 主要特性

- 支持调试任意已安装的 iOS 应用（包括 App Store 上下载的）
- 完全兼容 Dopamine 越狱环境
- 采用无根设计,安全可靠
- 无需配置直接使用

## 安装

- 已越狱的 iOS 设备 (使用 Dopamine)
- 安装了 Xcode 的 Mac 电脑
- 下载 Releases 的附件 deb文件 使用 `Sileo` 或者 `dpkg` 进行安装

## 使用

- 创建 Xcode 项目，选中越狱设备

![image-20241008172928806](README.assets/image-20241008172928806.png)

- 选择 `Debug` - `Attach to Process by PID or Name`

![image-20241008173034932](README.assets/image-20241008173034932.png)

- 输入要调试的可执行文件名称

![image-20241008173144917](README.assets/image-20241008173144917.png)

## 注意事项

本工具仅供开发学习使用,请遵守相关法律法规。
