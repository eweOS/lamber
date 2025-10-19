# Though stage3 is built with slibtool, we still need M4 files from libtool
# for compatibility.

$W/stage2.libtool.extract: $W/LIBTOOL.download
	tar xf $W/$(LIBTOOL_FILE) -C $W
	$(call done)

$W/stage2.libtool: $W/stage2.libtool.extract $W/stage2.m4
	cd $W/libtool-$(LIBTOOL_V) && ./configure --prefix=/usr

	+ make -C $W/libtool-$(LIBTOOL_V)
	+ make -C $W/libtool-$(LIBTOOL_V) install

	# We want the symlinks from slibtool
	rm /usr/bin/{libtool,libtoolize}

	$(call done)
