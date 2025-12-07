$W/stage2.libksba.extract: $W/LIBKSBA.download
	tar xf $W/$(LIBKSBA_FILE) -C $W
	$(call done)

$W/stage2.libksba: $W/stage2.libksba.extract \
	$W/stage2.base-devel $W/stage2.libgpg-error

	cd $W/libksba-$(LIBKSBA_V) && ./configure --prefix=/usr
	+ make -C $W/libksba-$(LIBKSBA_V)

	+ make -C $W/libksba-$(LIBKSBA_V) install

	$(call done)
