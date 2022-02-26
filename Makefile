.PHONY: clean macos ios simulator devices install_deps

install_deps:
	@flutter pub get

simulator:
	@open -a Simulator.app

ios: simulator
	@flutter run -d 'iphone 11'

macos:
	@flutter run -d macos

devices:
	@flutter devices

generate:
	@flutter pub run build_runner build

clean:
	@flutter clean