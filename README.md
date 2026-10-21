# Binary Receptor（条码接收器）
*目前仅支持 Windows。*

配合 [BinaryEye](https://github.com/markusfisch/BinaryEye) 使用，接收扫描到的条码并以键盘输入的方式输出。支持蓝牙或 HTTP 两种传输方式。


## 使用方法

### 在电脑上
1. 进入存放 `BinaryReceptorGUI.exe` 的文件夹。
2. 双击运行，程序会读取同目录下的 `settings.ini` 配置；也可以打开命令行窗口使用命令行参数启动。
3. 命令行版本为 `BinaryReceptor.exe`，可用参数如下：

```start BinaryReceptor.exe --mode [bluetooth|http] [--port 端口号]```
参数 | 说明
---|---
bluetooth | 默认启动模式，推荐使用。通过蓝牙接收 BinaryEye 的扫描内容。
http | 通过 HTTP 接收 BinaryEye 的扫描内容。由于 HTTP 会暴露键盘输入内容，存在安全风险，不推荐使用。
port | 可选。将默认端口号从 ```24234``` 改为指定值。
preType | 可选。键入内容前添加的前缀。
postType | 可选。键入内容后添加的后缀。
delimiters | 可选。内容分隔符，默认为 ```{}```。

### 在 BinaryEye 上
1. 打开 `设置` -> `转发` 页面。
2. 蓝牙方式：
    - 勾选 `使用蓝牙转发扫描内容`
    - 在 BinaryEye 中搜索并连接运行着 BinaryReceptor 的设备。
    - 将 `主机` 设置为运行 BinaryReceptor 的设备。

3. HTTP 方式：
    - 勾选 `转发扫描内容`。
    - 将 `请求类型` 设为 `GET 并附加内容`。
    - 将 `转发的 URL` 设置为本机的 IP 地址（需与 BinaryReceptor 使用同一网络）。


## 构建步骤
1. 下载依赖工具：
  - [Haxe](https://haxe.org)
  - [Dotnet 编译器](https://dotnet.microsoft.com/en-us/download)
  - [Just](https://github.com/casey/just)（可选）

2. 使用以下命令下载本项目的 Haxe 依赖库：
    - `haxelib install hxcpp 4.3.2`
    - `haxelib git hxBluetooth https://github.com/KamaleiZestri/hxBluetooth`
    - `haxelib git hxKeyType https://github.com/KamaleiZestri/hxKeyType`

3. 如果安装了 just，运行 `just fullrelease` 即可完成全部构建；否则请阅读 `justfile`（内容很简单）。

> 注意：Haxe 核心（`BinaryReceptor.exe`）依赖 MSVC 编译器，需要安装 Visual Studio Build Tools 的「使用 C++ 的桌面开发」工作负载。
