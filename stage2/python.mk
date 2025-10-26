$W/stage2.python.extract: $W/PYTHON.download
	tar xf $W/$(PYTHON_FILE) -C $W
	$(call done)

$W/stage2.python.patch: $W/stage2.python.extract $W/stage2.patch \
	$(SRCDIR)/stage2/python-0001-musl-find-library.patch

	patch -p1 -d $W/Python-$(PYTHON_V) < \
		$(SRCDIR)/stage2/python-0001-musl-find-library.patch

	sed -i 's@--print-multiarch@@g' $W/Python-$(PYTHON_V)/configure

	$(call done)

$W/stage2.python: $W/stage2.python.patch \
	$W/stage2.libffi $W/stage2.expat $W/stage2.sqlite $W/stage2.mpdecimal

	cd $W/Python-$(PYTHON_V) && ./configure --prefix=/usr \
		--with-system-ffi			\
		--with-computed-gotos			\
		--enable-ipv6				\
		--with-system-expat			\
		--enable-shared				\
		--without-static-libpython		\
		--with-system-libmpdec			\
		--with-ensurepip			\
		--enable-loadable-sqlite-extensions	\
		ax_cv_c_float_words_bigendian=no

	+ make -C $W/Python-$(PYTHON_V)
	+ make -C $W/Python-$(PYTHON_V) install

	ln -s python3			/usr/bin/python
	ln -s python-config		/usr/bin/python-config
	ln -s idle3			/usr/bin/idle

	$(call done)
