# solipsis_chat

This is the Flutter app for Solipsis.

# Development

## Pre-requisites

You need `bazel 4.2.1`.

## Setup

```shell
# Clone the `flutter_chat_ui` fork I created and this repo to the same directory.
git clone -b typing_indicator git@github.com:bitjockey42/flutter_chat_ui.git
git clone git@github.com:SolipsisAI/solipsis_chat.git

# Get dependencies
cd solipsis_chat
flutter pub get

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

# INSTALL LIBRARIES FOR DESKTOP
bash ./install_libs.sh

# INSTALL LIBRARIES FOR IOS
INCLUDE_IOS=true bash ./install_libs.sh

# Download model file and vocab text
bash ./download_assets.sh
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
```