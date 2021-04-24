
export ANDROID_SDK=/usr/local/share/android-sdk
export CMAKE=$ANDROID_SDK/cmake/3.6.4111459/bin/cmake
export NINJA=$ANDROID_SDK/cmake/3.6.4111459/bin/ninja
export CACHEDIR=./build

ABIS=(
    x86
    x86_64
    arm64-v8a
    armeabi-v7a)
# export OUT_DIR=./exec/x86_64

cmakefunc(){
export OUTPUT_DIR=../libs/$1

$CMAKE -Hcpp \
-B$CACHEDIR \
-G"Android Gradle - Ninja" \
-DANDROID_ABI=$1 \
-DANDROID_NDK=$ANDROID_SDK/ndk-bundle \
-DANDROID_PIE=true \
-DCMAKE_LIBRARY_OUTPUT_DIRECTORY=$OUTPUT_DIR \
-DCMAKE_BUILD_TYPE=Debug \
-DCMAKE_MAKE_PROGRAM=$NINJA \
-DCMAKE_TOOLCHAIN_FILE=$ANDROID_SDK/ndk-bundle/build/cmake/android.toolchain.cmake \
-DANDROID_NATIVE_API_LEVEL=28 \
-DANDROID_TOOLCHAIN=clang
cd $CACHEDIR
$NINJA
cd ..

rm -rf ./build
}

for i in "${ABIS[@]}"; do
    cmakefunc "$i"
done
echo done.
# -DANDROID_ABI=armeabi-v7a \
#TODO ABI convert to all types
