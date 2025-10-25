$W/stage2.automake.extract: $W/AUTOMAKE.download
	tar xf $W/$(AUTOMAKE_FILE) -C $W
	$(call done)

$W/stage2.automake: $W/stage2.automake.extract \
	$W/stage2.perl $W/stage2.autoconf
	cd $W/automake-$(AUTOMAKE_V) && ./configure --prefix=/usr

	+ make -C $W/automake-$(AUTOMAKE_V)
	+ make -C $W/automake-$(AUTOMAKE_V) install

	$(call done)
