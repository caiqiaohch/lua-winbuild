# windows版本 编译  lua 和 lua-jit的

## 使用命令行批处理编译

### 编译lua
处理lua.exe 编译之外 还有 lfs 和 md5 lua库的编译

```
cd lua
make_win.bat
```

### 编译lua-jit
支持64位gcc 的 luac 文件编译 和 32位的编译

```
cd lua-jit
make_win.bat

```
