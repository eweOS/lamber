$W/stage2.patch.extract: $W/PATCH.download
	tar xf $W/$(PATCH_FILE) -C $W
	$(call done)

$W/stage2.patch: $W/stage2.patch.extract $W/stage2.autoconf $W/stage2.automake
	cd $W/patch-$(PATCH_V) && autoreconf -fiv && \
		./configure --prefix=/usr

	+ make -C $W/patch-$(PATCH_V)
	+ make -C $W/patch-$(PATCH_V) install

	$(call done)
