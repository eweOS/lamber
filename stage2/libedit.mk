$W/stage2.libedit.extract: $W/LIBEDIT.download
	tar xf $W/$(LIBEDIT_FILE) -C $W
	$(call done)

$W/stage2.libedit: $W/stage2.libedit.extract
	cd $W/libedit-$(LIBEDIT_V) && ./configure --prefix=/usr \
		CFLAGS="-D__STDC_ISO_10646__=201103L"

	+ make -C $W/libedit-$(LIBEDIT_V)
	+ make -C $W/libedit-$(LIBEDIT_V) install

	$(call done)
