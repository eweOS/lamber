$W/stage2.skalibs.extract: $W/SKALIBS.download
	tar xf $W/$(SKALIBS_FILE) -C $W
	$(call done)

$W/stage2.skalibs: $W/stage2.skalibs.extract
	cd $W/skalibs-$(SKALIBS_V) && ./configure --prefix=/usr \
		--enable-force-devr		\
		--enable-tai-clock		\
		--enable-pkgconfig

	+ make -C $W/skalibs-$(SKALIBS_V)
	+ make -C $W/skalibs-$(SKALIBS_V) install

	$(call done)
