$W/stage2.npth.extract: $W/NPTH.download
	tar xf $W/$(NPTH_FILE) -C $W
	$(call done)

$W/stage2.npth: $W/stage2.npth.extract $W/stage2.base-devel
	cd $W/npth-$(NPTH_V) && autoreconf -fiv

	cd $W/npth-$(NPTH_V) && ./configure --prefix=/usr
	+ make -C $W/npth-$(NPTH_V)

	+ make -C $W/npth-$(NPTH_V) install

	$(call done)
