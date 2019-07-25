Lookin的Loader，与RevealLoader功能 一致。

使用方法:
1.   编译并安装到设备
2.  将`LookinServer` 放置目录`/Library/LookinLoader/LookinServer`，iOS12 参考以下 步骤


iOS 12使用流程
1. 下载[LookinServer](https://raw.githubusercontent.com/QMUI/LookinServer/master/LookinServer.framework/LookinServer)
2. `lipo -thin arm64 LookinServer -output LookinServer1`
3. `codesign -f -s "iPhone Developer: xxxxxx" LookinServer1`
4. `scp LookinServer1 root@xxx.xxx.xxx.xxx:/Library/LookinLoader/LookinServer`,  确保设备有`/Library/LookinLoader/`这个目录。

TODO:
1. iOS 12使用`jtool`  签名之后仍然无法在越狱设备上运行
2. 添加自动更新`LookinServer`的功能

参考:
1. [Reveal-Loader](https://github.com/jkyin/Reveal-Loader)
2. [Lookin](https://lookin.work/)

