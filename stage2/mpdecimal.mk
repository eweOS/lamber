$W/stage2.mpdecimal.extract: $W/MPDECIMAL.download
	tar xf $W/$(MPDECIMAL_FILE) -C $W
	$(call done)

$W/stage2.mpdecimal: $W/stage2.mpdecimal.extract
	cd $W/mpdecimal-$(MPDECIMAL_V) && ./configure --prefix=/usr

	+ make -C $W/mpdecimal-$(MPDECIMAL_V)
	+ make -C $W/mpdecimal-$(MPDECIMAL_V) install

	$(call done)
