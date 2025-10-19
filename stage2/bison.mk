$W/stage2.bison.extract: $W/BISON.download
	tar xf $W/$(BISON_FILE) -C $W

	$(call done)

$W/stage2.bison: $W/stage2.bison.extract
	cd $W/bison-$(BISON_V) && ./configure --prefix=/usr \
		--datadir=/usr/share

	+ make -C $W/bison-$(BISON_V)
	+ make -C $W/bison-$(BISON_V) install

	$(call done)
