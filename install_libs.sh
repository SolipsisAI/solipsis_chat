#!/usr/bin/env bash
PROJECT_DIR="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"

BAZEL_VERSION=3.7.2
TF_VERSION=2.8

BASE_LIB_FILENAME="libtensorflowlite_c"


setup_linux () {
    sudo apt -y install curl gnupg
    curl -fsSL https://bazel.build/bazel-release.pub.gpg | gpg --dearmor > bazel.gpg
    sudo mv bazel.gpg /etc/apt/trusted.gpg.d/
    echo "deb [arch=amd64] https://storage.googleapis.com/bazel-apt stable jdk1.8" | sudo tee /etc/apt/sources.list.d/bazel.list

    sudo apt -y update && sudo apt -y install bazel-$BAZEL_VERSION
    sudo ln -s /usr/bin/bazel-$BAZEL_VERSION /usr/bin/bazel 
}

build_binaries () {
    cd ..
    git clone https://github.com/tensorflow/tensorflow.git
    cd tensorflow
    git checkout r$TF_VERSION
    bazel build -c opt //tensorflow/lite/c:tensorflowlite_c --define tflite_with_xnnpack=true
}

copy_to_project () {
    mkdir -p $PROJECT_DIR/blobs
    cp $PROJECT_DIR/../tensorflow/bazel-bin/tensorflow/lite/c/$src_filename $PROJECT_DIR/blobs/$dest_filename
}

unamestr=$(uname)
if [[ "$unamestr" == 'Linux' ]]; then
    echo "Setting up on Linux"
    src_filename="${BASE_LIB_FILENAME}.so"
    dest_filename="${BASE_LIB_FILENAME}-linux.so"
    setup_linux
elif [[ "$unamestr" == 'Darwin' ]]; then
    echo "macos"
    src_filename="${BASE_LIB_FILENAME}.dylib"
    dest_filename="${BASE_LIB_FILENAME}-mac.dylib"
else
    echo "Unsupported"
    exit 1
fi

build_binaries
copy_to_project