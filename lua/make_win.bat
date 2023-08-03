@echo off

:: lua paths define
set LUAJIT_PATH=.
set STANDARD_LUA_PATH=lua-5.1.5

:: deciding whether to use luajit or not
set USE_STANDARD_LUA=%1%
set USE_LUA_PATH=%LUAJIT_PATH%
if "%USE_STANDARD_LUA%"=="YES" (set USE_LUA_PATH=%STANDARD_LUA_PATH%)

:: get visual studio tools path
:check2015
if exist "%VS130COMNTOOLS%" (
    set VS_TOOL_VER=vs130
    set VCVARS="%VS130COMNTOOLS%..\..\VC\bin\"
    goto build
)
:check2013
if exist "%VS120COMNTOOLS%" (
    set VS_TOOL_VER=vs120
    set VCVARS="%VS120COMNTOOLS%..\..\VC\bin\"
    goto build
)
:check2012
if exist "%VS110COMNTOOLS%" (
    set VS_TOOL_VER=vs110
    set VCVARS="%VS110COMNTOOLS%..\..\VC\bin\"
    goto build
)
:check2010
if exist "%VS100COMNTOOLS%" (
    set VS_TOOL_VER=vs100
    set VCVARS="%VS100COMNTOOLS%..\..\VC\bin\"
    goto build
)
:check2008
if exist "%VS90COMNTOOLS%" (
    set VS_TOOL_VER=vs90
    set VCVARS="%VS90COMNTOOLS%..\..\VC\bin\"
    goto build
)
else (
    goto missing
)

:build
set ENV32="%VCVARS%vcvars32.bat"
set ENV64="%VCVARS%amd64\vcvars64.bat"

echo %ENV32%
echo %ENV64%

call "%ENV64%"
echo Swtich to x86 build env(%VS_TOOL_VER%)
cd src
cl /O2 /W3 /c /DLUA_BUILD_AS_DLL l*.c
del lua.obj luac.obj
link /DLL /out:lua54.dll l*.obj
cl /O2 /W3 /c /DLUA_BUILD_AS_DLL lua.c luac.c
link /out:lua.exe lua.obj lua54.lib
del lua.obj
link /out:luac.exe l*.obj
copy /Y lua54.lib ..\lib\lua54.lib
copy /Y lua.exe ..\bin\lua.exe
copy /Y luac.exe ..\bin\luac.exe
copy /Y lua54.dll ..\bin\lua54.dll

cd ../lfs
cl /O2 /W3  /wd"4996" /wd"4267" /c /DLUA_BUILD_AS_DLL l*.c /I"../include/"
link /DLL /out:lfs.dll l*.obj ../lib/lua54.lib
copy /Y lfs.dll ..\bin\lfs.dll

cd ../lua-md5
cl /O2 /W3 /c /DLUA_BUILD_AS_DLL md5.c md5lib.c compat-5.2.c  /I"../include/"
link /DLL /out:md5.dll *.obj ../lib/lua54.lib
copy /Y md5.dll ..\bin\md5.dll


cd ..
goto :eof

:missing
echo Can't find Visual Studio, compilation fails!

goto :eof
