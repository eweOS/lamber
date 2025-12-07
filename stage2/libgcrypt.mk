$W/stage2.libgcrypt.extract: $W/LIBGCRYPT.download
	tar xf $W/$(LIBGCRYPT_FILE) -C $W
	$(call done)

$W/stage2.libgcrypt: $W/stage2.libgcrypt.extract $W/stage2.base-devel \
	$W/stage2.libgpg-error

	cd $W/libgcrypt-$(LIBGCRYPT_V) && autoreconf -fiv

	cd $W/libgcrypt-$(LIBGCRYPT_V) && ./configure --prefix=/usr
	+ make -C $W/libgcrypt-$(LIBGCRYPT_V)
	+ make -C $W/libgcrypt-$(LIBGCRYPT_V) install

	$(call done)
