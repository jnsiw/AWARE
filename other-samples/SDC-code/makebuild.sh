
export NDK=/usr/local/share/android-sdk/ndk-bundle

# test version
# $NDK/build/tools/make_standalone_toolchain.py --arch x86_64 --api 28 --install-dir ./toolchain
export SYSROOT=$NDK/platforms/android-28/arch-x86_64
export CC="$NDK/toolchains/llvm/prebuilt/darwin-x86_64/bin/clang --sysroot=$SYSROOT -target x86_64-gcc-toolchain $NDK/toolchains/x86_64-4.9/prebuilt/darwin-x86_64"

# Tell configure what flags Android requires.
export CFLAGS="-fPIE -fPIC"
export LDFLAGS="-pie"

$CC hello.c -o hello -fPIE -fpic -march=x86-64 -mtune=intel -O3


# release version
# export SYSROOT=$NDK/platforms/android-26/arch-arm64
# export CC="$NDK/toolchains/llvm/prebuilt/darwin-x86_64/bin/clang --sysroot=$SYSROOT -target aarch64-linux-androideabi-gcc-toolchain $NDK/toolchains/aarch64-linux-android-4.9/prebuilt/darwin-x86_64"
# $CC hello.c -o hello -fPIE -fpic -march=armv8-a -mtune=cortex-a53 -O3
