$W/stage2.libbz2.extract: $W/LIBBZ2.download
	tar xf $W/$(LIBBZ2_FILE) -C $W
	$(call done)

$W/stage2.libbz2.patch: $W/stage2.libbz2.extract $W/stage2.patch \
	$(SRCDIR)/stage2/libbz2-0001-disable-tests.patch

	patch -p1 -d $W/bzip2-$(LIBBZ2_COMMIT) < \
		$(SRCDIR)/stage2/libbz2-0001-disable-tests.patch

	$(call done)

$W/stage2.libbz2: $W/stage2.libbz2.patch $W/stage2.meson
	ewe-meson $W/bzip2-$(LIBBZ2_COMMIT) $W/libbz2-build \
		-D docs=disabled

	+ meson compile -C $W/libbz2-build
	# Note: This will override the bzip2 binary provided by busybox
	+ meson install -C $W/libbz2-build

	$(call done)
