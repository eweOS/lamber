$W/stage2.slibtool.extract: $W/SLIBTOOL.download
	tar xf $W/$(SLIBTOOL_FILE) -C $W

	$(call done)

$W/stage2.slibtool: $W/stage2.libtool $W/stage2.slibtool.extract
	# We need to explicitly instruct slibtool's configuration system to
	# pass --no-print-directory when invoking make: it generates CFLAGS
	# with a Makefile, and without --no-print-directory the verbose
	# messages of entering/leaving directories could confuse the script.

	cd $W/slibtool-$(SLIBTOOL_V) && env MAKE="make --no-print-directory" \
		./configure --prefix=/usr

	+ make -C $W/slibtool-$(SLIBTOOL_V)
	+ make -C $W/slibtool-$(SLIBTOOL_V) install

	$(call done)
