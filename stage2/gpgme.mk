$W/stage2.gpgme.extract: $W/GPGME.download
	tar xf $W/$(GPGME_FILE) -C $W
	$(call done)

$W/stage2.gpgme: $W/stage2.gpgme.extract $W/stage2.base-devel \
	$W/stage2.gnupg $W/stage2.libgpg-error

	cd $W/gpgme-$(GPGME_V) && env CFLAGS="-D_LARGEFILE64_SOURCE" \
		./configure --prefix=/usr	\
			--disable-fd-passing	\
			--disable-static	\
			--disable-gpgsm-test

	+ make -C $W/gpgme-$(GPGME_V)
	+ make -C $W/gpgme-$(GPGME_V) install

	$(call done)
