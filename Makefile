.PHONY: iso release serve clean

iso:
	./build/build-iso.sh

release:
	./build/release-iso.sh

serve:
	cd dist/release && python3 -m http.server 8000

clean:
	rm -rf .live-build
