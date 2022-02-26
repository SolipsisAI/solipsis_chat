.PHONY: clean macos ios

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

clean:
	@flutter clean