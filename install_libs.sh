#!/usr/bin/env bash

BAZEL_VERSION=4.1.0
TF_VERSION=2.5

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

unamestr=$(uname)
if [[ "$unamestr" == 'Linux' ]]; then
    echo "Setting up on Linux"
    setup_linux
    build_binaries
elif [[ "$unamestr" == 'Darwin' ]]; then
    echo "macos"
else
    echo "Unsupported"
    exit 1
fi
