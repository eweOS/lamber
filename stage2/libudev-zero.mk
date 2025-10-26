$W/stage2.libudev-zero.extract: $W/LIBUDEV.download
	tar xf $W/$(LIBUDEV_FILE) -C $W
	$(call done)

$W/stage2.libudev-zero: $W/stage2.libudev-zero.extract
	+ make -C $W/libudev-zero-$(LIBUDEV_COMMIT) LIBUDEV_VER=$(LIBUDEV_V)
	+ make -C $W/libudev-zero-$(LIBUDEV_COMMIT) LIBUDEV_VER=$(LIBUDEV_V) \
		install PREFIX=/usr

	$(call done)
