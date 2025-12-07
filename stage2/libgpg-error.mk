$W/stage2.libgpg-error.extract: $W/LIBGPG_ERR.download
	tar xf $W/$(LIBGPG_ERR_FILE) -C $W
	$(call done)

$W/stage2.libgpg-error: $W/stage2.libgpg-error.extract $W/stage2.base-devel
	cd $W/libgpg-error-$(LIBGPG_ERR_V) && autoreconf -fiv

	cd $W/libgpg-error-$(LIBGPG_ERR_V) && ./configure --prefix=/usr
	+ make -C $W/libgpg-error-$(LIBGPG_ERR_V)

	+ make -C $W/libgpg-error-$(LIBGPG_ERR_V) install

	$(call done)
