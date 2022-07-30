# solipsis_chat

This is the Flutter app for Solipsis.

# Development

## Pre-requisites

- Flutter
- TensorFlow

## Setup

```shell
# Clone the `flutter_chat_ui` fork I created and this repo to the same directory.
git clone -b typing_indicator git@github.com:bitjockey42/flutter_chat_ui.git
git clone git@github.com:SolipsisAI/solipsis_chat.git
```

Set up python:
```shell
pyenv install miniforge3
pyenv local miniforge3
conda create --name tf
conda activate tf
conda install numpy

pyenv local miniforge3/envs/tf
TF_CONFIGURE_IOS=True ./configure
echo $PYENV_VERSION
conda deactivate
export PYENV_VERSION=miniforge3/envs/tf
```

Edit `tensorflow/lite/ios/ios.bzl` and increase the `TFL_MINIMUM_OS_VERSION` to `12.0` (from [here](https://github.com/tensorflow/tensorflow/issues/55322#issuecomment-1121003765)):
```
diff --git a/tensorflow/lite/ios/ios.bzl b/tensorflow/lite/ios/ios.bzl
index d9cb812ab76..38be024be49 100644
--- a/tensorflow/lite/ios/ios.bzl
+++ b/tensorflow/lite/ios/ios.bzl
@@ -5,7 +5,7 @@ load("//tensorflow:tensorflow.bzl", "clean_dep")
 # Placeholder for Google-internal load statements.
 load("@build_bazel_rules_apple//apple:ios.bzl", "ios_static_framework")
 
-TFL_MINIMUM_OS_VERSION = "9.0"
+TFL_MINIMUM_OS_VERSION = "12.0"
 
 # Default tags for filtering iOS targets. Targets are restricted to Apple platforms.
 TFL_DEFAULT_TAGS = [

```

Then continue the installation:
```shell
# Set TF_DIR for later
export TF_DIR=$(pwd)

# Configure to build iOS libraries
TF_CONFIGURE_IOS=True ./configure  # Use default values

# Build
bazel build --config=ios_fat -c opt \
  //tensorflow/lite/ios:TensorFlowLiteC_framework
```

If this succeeds, then there should be a zip file generated to the file:
`bazel-bin/tensorflow/lite/ios/TensorFlowLiteC_framework.zip`

### Installing to flutter

```shell
cd path/to/flutter-project
export PROJECT_DIR=$(pwd)
export TFLITE_IOS_DIR=$(PROJECT_DIR)/ios/.symlinks/plugins/tflite_flutter/ios
```