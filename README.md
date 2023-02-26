# solipsis_chat

This is the Flutter app for Solipsis.

- [solipsis\_chat](#solipsis_chat)
- [Development](#development)
  - [Pre-requisites](#pre-requisites)
  - [Automated Setup](#automated-setup)
  - [Setup with pre-built libraries](#setup-with-pre-built-libraries)
    - [iOS](#ios)
    - [Linux](#linux)
    - [macOS](#macos)
  - [Python manual setup](#python-manual-setup)
  - [Running app](#running-app)
- [Troubleshooting](#troubleshooting)
  - [`numpy` not found](#numpy-not-found)

# Development

## Pre-requisites

- [`fvm`](https://fvm.app/docs/getting_started/installation) for managing multiple flutter versions, in this case 3.3.8
- `bazel-5.0.0` to be installed by `install_libs.sh`
- `python3` which can be set up by the `install_libs.sh` script.
- `numpy` same as above
- [`TensorFlowLiteC.framework`](https://solipsis-data.s3.us-east-2.amazonaws.com/pkg/TensorFlowLiteC.framework.zip)

## Automated Setup

```shell
# Clone the `flutter_chat_ui` fork I created and this repo to the same directory.
git clone -b typing_indicator git@github.com:bitjockey42/flutter_chat_ui.git
git clone git@github.com:SolipsisAI/solipsis_chat.git

# Clone the `text_classifiers`
git clone git@github.com:SolipsisAI/text_classifiers_flutter.git

# Clone `tflite_flutter_plugin` which is a dep of the above
git clone git@github.com:SolipsisAI/tflite_flutter_plugin.git

# Get dependencies
cd solipsis_chat
flutter pub get
```

Then run the script:
```shell
# INSTALL LIBRARIES FOR DESKTOP
bash ./install_libs.sh

# INSTALL LIBRARIES FOR IOS
INCLUDE_IOS=true bash ./install_libs.sh
```

In the `text_classifiers_flutter`:
```shell
cd ../text_classifiers_flutter
# Download model file and vocab text
bash ./download_assets.sh
```

## Setup with pre-built libraries

### iOS

Download [TensorFlowLiteC.framework.zip](https://solipsis-data.s3.us-east-2.amazonaws.com/pkg/TensorFlowLiteC.framework.zip).

In terminal:
```shell
# Install dependencies
fvm flutter clean
fvm flutter pub get

# Download framework
curl -LO https://solipsis-data.s3.us-east-2.amazonaws.com/pkg/TensorFlowLiteC.framework.zip 
unzip TensorFlowLiteC.framework.zip -d ios/.symlinks/plugins/tflite_flutter/ios

# Setup with flutter
cd ios
pod install
fvm flutter clean
fvm flutter pub get
```

### Linux

Download [libtensorflowlite_c-linux.so](https://solipsis-data.s3.us-east-2.amazonaws.com/blobs/libtensorflowlite_c-linux.so) and place in `blobs/`:

```shell
mkdir -p blobs
cd blobs
curl -LO https://solipsis-data.s3.us-east-2.amazonaws.com/blobs/libtensorflowlite_c-linux.so
cd ..
```

### macOS

Download [libtensorflowlite_c-mac.dylib](https://solipsis-data.s3.us-east-2.amazonaws.com/blobs/libtensorflowlite_c-mac.dylib) and place in `blobs/`:

```shell
mkdir -p blobs
cd blobs
curl -LO https://solipsis-data.s3.us-east-2.amazonaws.com/blobs/libtensorflowlite_c-mac.dylib
cd ..
```

## Python manual setup

```shell
# SETUP PYTHON
pyenv install miniforge3

# Activate miniforge3
pyenv shell miniforge3

# Setup conda environment
conda create --name tensorflow # this can be any name

# Activate environment
conda activate tensorflow

# Install numpy
conda install numpy
```

## Running app

```shell
$ flutter devices # list devices that flutter can run on

2 connected devices:

macOS (desktop) • macos  • darwin-arm64   • macOS 12.0.1 21A559 darwin-arm
Chrome (web)    • chrome • web-javascript • Google Chrome 98.0.4758.102

$ open -a Simulator.app # launch iOS Simulator
$ flutter devices

3 connected devices:

iPhone 11 (mobile) • longstringhere • ios            • com.apple.CoreSimulator.SimRuntime.iOS-15-2 (simulator)
macOS (desktop)    • macos                                • darwin-arm64   • macOS 12.0.1 21A559 darwin-arm
Chrome (web)       • chrome                               • web-javascript • Google Chrome 98.0.4758.102

$ flutter run -d 'iphone 11' # launch app in Simulator

# Launch on Linux
$ flutter run -d linux --verbose
```

# Troubleshooting

## `numpy` not found

If you are using `pyenv` and a `venv`, make sure `pyenv` is set up in your shell configuration. And use a different terminal window.
