#!/usr/bin/env bash
PROJECT_DIR="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"
TF_DIR=${PROJECT_DIR}/../tensorflow
BLOBS_DIR=$HOME/Library/Containers/ai.solipsis.Solipsis/Data/blobs
TFLITE_IOS_DIR=$PROJECT_DIR/ios/.symlinks/plugins/tflite_flutter/ios

BAZEL_VERSION=5.0.0
TF_VERSION=2.9

BASE_LIB_FILENAME="libtensorflowlite_c"

setup_python () {
    pyenv install miniforge3

    # Activate miniforge3
    pyenv shell miniforge3

    # Setup conda environment
    conda create --name tensorflow # this can be any name

    # Activate environment
    conda activate tensorflow

    # Install numpy
    conda install numpy
}

setup_linux () {
    sudo apt -y install curl gnupg
    curl -fsSL https://bazel.build/bazel-release.pub.gpg | gpg --dearmor > bazel.gpg
    sudo mv bazel.gpg /etc/apt/trusted.gpg.d/
    echo "deb [arch=amd64] https://storage.googleapis.com/bazel-apt stable jdk1.8" | sudo tee /etc/apt/sources.list.d/bazel.list

    sudo apt -y update && sudo apt -y install bazel-$BAZEL_VERSION
    sudo ln -s /usr/bin/bazel-$BAZEL_VERSION /usr/bin/bazel 
}

build_binaries () {
    cd $PROJECT_DIR/..

    if [ ! -d "$TF_DIR" ]; then
        git clone https://github.com/tensorflow/tensorflow.git
    fi

    cd $TF_DIR

    git checkout r$TF_VERSION
    # Must be built on x86_64
    arch -x86_64 bazel build -c opt //tensorflow/lite/c:tensorflowlite_c --define tflite_with_xnnpack=true
}

build_ios_binaries () {
    cd $PROJECT_DIR/..

    if [ ! -d "$TF_DIR" ]; then
        git clone https://github.com/tensorflow/tensorflow.git
    fi

    cd $TF_DIR

    bazel clean
    TF_CONFIGURE_IOS=True ./configure
    bazel build --config=ios_fat -c opt \
        //tensorflow/lite/ios:TensorFlowLiteC_framework

    unzip $TF_DIR/bazel-bin/tensorflow/lite/ios/TensorFlowLiteC_framework.zip \
        -d $TFLITE_IOS_DIR
    
    # This is absolutely necessary
    cd $PROJECT_DIR
    flutter clean
    flutter pub get
    cd $PROJECT_DIR/ios 
    pod install
    cd $PROJECT_DIR
}

copy_to_project () {
    mkdir -p $BLOBS_DIR
    cp $TF_DIR/bazel-bin/tensorflow/lite/c/$src_filename $BLOBS_DIR/$dest_filename
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
    dest_filename="${BASE_LIB_FILENAME}-mac.so" # the tflite_flutter plugin looks for a *.so file
else
    echo "Unsupported"
    exit 1
fi

if [ ! -d  "$BLOBS_DIR/$dest_filename" ]; then
    echo "[INFO] Building macOS dependencies"
    # build_binaries
    # copy_to_project
    build_ios_binaries
    echo "[SUCCESS] $dest_filename copied to $BLOBS_DIR"
fi