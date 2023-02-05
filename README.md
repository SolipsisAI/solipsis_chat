# solipsis_chat

This is the Flutter app for Solipsis.

# Development

## Pre-requisites

- [`fvm`](https://fvm.app/docs/getting_started/installation) for managing multiple flutter versions, in this case 3.3.8
- `bazel-5.0.0` to be installed by `install_libs.sh`
- `python3` which can be set up by the `install_libs.sh` script.
- `numpy` same as above

## Automated Setup

```shell
# Clone the `flutter_chat_ui` fork I created and this repo to the same directory.
git clone -b typing_indicator git@github.com:bitjockey42/flutter_chat_ui.git
git clone git@github.com:SolipsisAI/solipsis_chat.git

# Clone the `text_classifiers`
git clone git@github.com:SolipsisAI/text_classifiers_flutter.git

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

# Download model file and vocab text
bash ./download_assets.sh
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
```