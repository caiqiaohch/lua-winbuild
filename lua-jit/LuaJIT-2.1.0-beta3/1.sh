#!/bin/bash

NDKPATH=/cygdrive/c/Users/Admin/AppData/Local/Android/Sdk/ndk/android-ndk-r12b
NDKABI=23
NDKVER=$NDKPATH/toolchains/arm-linux-androideabi-4.9
NDKP=$NDKVER/prebuilt/windows-x86_64/bin/arm-linux-androideabi-
NDKF="--sysroot $NDKPATH/platforms/android-$NDKABI/arch-arm"
NDKARCH="-march=armv7-a -mfloat-abi=softfp -Wl,--fix-cortex-a8"
NDK_MAKE=$NDKPATH/prebuilt/windows-x86_64/bin/make.exe
echo "1 $NDKVER"
echo "2 $NDKP"
echo "3 $NDKF"
echo "4 $NDKARCH"
echo "5 NDK_MAKE $NDK_MAKE"

make HOST_CC="gcc -m32" CROSS=$NDKP TARGET_FLAGS="$NDKF $NDKARCH" TARGET_SYS="Linux" clean default
