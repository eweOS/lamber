$W/stage2.libffi.extract: $W/LIBFFI.download
	tar xf $W/$(LIBFFI_FILE) -C $W
	$(call done)

$W/stage2.libffi: $W/stage2.libffi.extract
	cd $W/libffi-$(LIBFFI_V) && ./configure --prefix=/usr \
		--disable-exec-static-tramp		\
		--disable-multi-os-directory		\
		--enable-shared

	+ make -C $W/libffi-$(LIBFFI_V)
	+ make -C $W/libffi-$(LIBFFI_V) install

	$(call done)
