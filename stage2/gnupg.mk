$W/stage2.gnupg.extract: $W/GNUPG.download
	tar xf $W/$(GNUPG_FILE) -C $W
	$(call done)

$W/stage2.gnupg: $W/stage2.gnupg.extract $W/stage2.base-devel \
	$W/stage2.libassuan $W/stage2.libgpg-error $W/stage2.npth	\
	$W/stage2.libksba $W/stage2.pinentry $W/stage2.libgcrypt

	cd $W/gnupg-$(GNUPG_V) && ./configure --prefix=/usr \
		--with-libksba-prefix=/usr	\
		--sbindir=/usr/bin		\
		--libexecdir=/usr/lib/gnupg

	+ make -C $W/gnupg-$(GNUPG_V)
	+ make -C $W/gnupg-$(GNUPG_V) install

	$(call done)
