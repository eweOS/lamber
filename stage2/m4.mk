$W/stage2.m4.extract: $W/M4.download
	tar xf $W/$(M4_FILE) -C $W
	$(call done)

$W/stage2.m4: $W/stage2.m4.extract
	cd $W/m4-$(M4_V) && ./configure --prefix=/usr

	+ make -C $W/m4-$(M4_V)
	+ make -C $W/m4-$(M4_V) install

	$(call done)
