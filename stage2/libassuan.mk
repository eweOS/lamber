$W/stage2.libassuan.extract: $W/LIBASSUAN.download
	tar xf $W/$(LIBASSUAN_FILE) -C $W
	$(call done)

$W/stage2.libassuan: $W/stage2.libassuan.extract \
	$W/stage2.base-devel $W/stage2.libgpg-error

	cd $W/libassuan-$(LIBASSUAN_V) && ./configure --prefix=/usr
	+ make -C $W/libassuan-$(LIBASSUAN_V)

	+ make -C $W/libassuan-$(LIBASSUAN_V) install

	$(call done)
