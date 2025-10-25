$W/stage1.musl-extract: $W/MUSL.download
	tar xf $W/$(MUSL_FILE) -C $W

	$(call done)

$W/stage1.musl-headers: $W/stage0 $W/stage1.musl-extract
	$(call s1) make -C $W/musl-$(MUSL_V) distclean

	cd $W/musl-$(MUSL_V) && 	\
	$(call s1) ./configure --prefix=/usr	\
		--syslibdir=$O/usr/lib		\
		--host=$(CHOST)

	+ $(call s1) make -C $W/musl-$(MUSL_V) \
		install-headers DESTDIR=$O

	$(call done)

$W/stage1.musl-lib: $W/stage1.musl-headers $W/stage1.compiler-rt
	$(call s1) make -C $W/musl-$(MUSL_V) distclean

	cd $W/musl-$(MUSL_V) && 	\
	$(call s1) AR=llvm-ar RANLIB=llvm-ranlib \
		./configure --prefix=/usr	\
		--syslibdir=/usr/lib		\
		--host=$(CHOST)

	+ $(call s1) make -C $W/musl-$(MUSL_V)
	+ $(call s1) make -C $W/musl-$(MUSL_V) install DESTDIR=$O

	$(call done)
