all: linux macos windows zip

clean:
	rm -rf build

linux:
	mkdir -p build/linux
	godot4 -v --headless --export-release "Linux/X11" ../build/linux/Frouldron.x86_64 project/project.godot

macos:
	mkdir -p build/macos
	godot4 -v --headless --export-release "macOS" ../build/macos/Frouldron.dmg project/project.godot

windows:
	mkdir -p build/windows
	godot4 -v --headless --export-release "Windows Desktop" ../build/windows/Frouldron.exe project/project.godot

zip: linux macos windows
	mkdir -p build/zip
	mkdir -p build/zip/src
	rsync -av --progress project build/zip/src --exclude .godot/
	echo "This project was built using [Godot Engine](https://godotengine.org)." > build/zip/src/README.md
	mkdir -p build/zip/release/linux
	mkdir -p build/zip/release/macos
	mkdir -p build/zip/release/windows
	cp -r build/linux/* build/zip/release/linux
	cp -r build/macos/* build/zip/release/macos
	cp -r build/windows/* build/zip/release/windows
	cp LICENSE build/zip
	mkdir -p build/zip/press
	cp press/*png build/zip/press
	cd build;	zip Frouldron.zip -r zip
