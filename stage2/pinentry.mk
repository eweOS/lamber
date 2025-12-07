$W/stage2.pinentry.extract: $W/PINENTRY.download
	tar xf $W/$(PINENTRY_FILE) -C $W
	$(call done)

$W/stage2.pinentry: $W/stage2.pinentry.extract $W/stage2.base-devel \
	$W/stage2.libgpg-error $W/stage2.libassuan

	cd $W/pinentry-$(PINENTRY_V) && ./configure --prefix=/usr \
		--enable-pinentry-tty		\
		--enable-pinentry-curses

	+ make -C $W/pinentry-$(PINENTRY_V)
	+ make -C $W/pinentry-$(PINENTRY_V) install

	$(call done)
