$W/stage2.utmps.extract: $W/UTMPS.download
	tar xf $W/$(UTMPS_FILE) -C $W
	$(call done)

$W/stage2.utmps: $W/stage2.utmps.extract $W/stage2.skalibs
	cd $W/utmps-$(UTMPS_V) && ./configure --prefix=/usr \
		--bindir=/usr/bin				\
		--libdir=/usr/lib				\
		--with-sysdeps=/usr/lib/skalibs/sysdeps		\
		--enable-libc-includes				\
		--enable-shared					\
		--disable-allstatic				\
		--enable-utmp					\
		--enable-pkgconfig

	+ make -C $W/utmps-$(UTMPS_V)
	+ make -C $W/utmps-$(UTMPS_V) install

	$(call done)
