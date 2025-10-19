$W/stage2.autoconf.extract: $W/AUTOCONF.download
	tar xf $W/$(AUTOCONF_FILE) -C $W

	$(call done)

$W/stage2.autoconf: $W/stage2.autoconf.extract \
	$W/stage2.perl $W/stage2.m4
	cd $W/autoconf-$(AUTOCONF_V) && ./configure --prefix=/usr

	+ make -C $W/autoconf-$(AUTOCONF_V)
	+ make -C $W/autoconf-$(AUTOCONF_V) install

	$(call done)
