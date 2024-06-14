Lookin的Loader，与RevealLoader功能 一致。

使用方法:
1.   编译并安装到设备


iOS 12使用流程
1. 使用命令查看 identity `security find-identity -p codesigning -v`
2. `codesign -f -s "iPhone Developer: xxxxxx" layout/Library/LookinLoader/LookinServer`
3. 编译并安装到设备

TODO:
1. iOS 12使用`jtool`  签名之后仍然无法在越狱设备上运行
2. 添加自动更新`LookinServer`的功能

参考:
1. [Reveal-Loader](https://github.com/jkyin/Reveal-Loader)
2. [Lookin](https://lookin.work/)

