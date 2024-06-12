ARCH:=$(shell dpkg-architecture -qDEB_HOST_ARCH)
VERSION=0.0.1

BUILD_DIR=./build
DIST_DIR=./dist
CC=cc

.PHONY: clean build
build: $(DIST_DIR)/envrpl $(DIST_DIR)/envrpl_$(VERSION)_$(ARCH).deb
clean:
	rm -rf build dist

$(DIST_DIR)/envrpl_$(VERSION)_$(ARCH).deb: $(BUILD_DIR)/envrpl_$(VERSION)_$(ARCH)
	dpkg-deb --build $(BUILD_DIR)/envrpl_$(VERSION)_$(ARCH) $(DIST_DIR)/envrpl_$(VERSION)_$(ARCH).deb


$(BUILD_DIR)/envrpl_$(VERSION)_$(ARCH): $(DIST_DIR)/envrpl
	mkdir -p $@/usr/bin
	mkdir -p $@/DEBIAN
	
	cp $(DIST_DIR)/envrpl $@/usr/bin/envrpl
	chown root:root $@/usr/bin/envrpl
	
	echo "Package: envrpl" > $@/DEBIAN/control
	echo "Description: Replace environment variables in files" >> $@/DEBIAN/control
	echo "Version: $(VERSION)" >> $@/DEBIAN/control
	echo "Architecture: $(ARCH)" >> $@/DEBIAN/control
	echo "Maintainer: GDWR <gregory.dwr@gmail.com>" >> $@/DEBIAN/control


$(DIST_DIR)/envrpl: $(BUILD_DIR)/main.o
	mkdir -p $(DIST_DIR)
	cp $(BUILD_DIR)/envrpl.o $(DIST_DIR)/envrpl

$(BUILD_DIR)/main.o: src/main.c
	mkdir -p $(BUILD_DIR)
	$(CC) -O3 -Wall -DVERSION="\"envrpl $(VERSION)\"" src/main.c -o $(BUILD_DIR)/envrpl.o

