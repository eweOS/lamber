$W/stage2.pcre2.extract: $W/PCRE2.download
	tar xf $W/$(PCRE2_FILE) -C $W

	$(call done)

$W/stage2.pcre2: $W/stage2.pcre2.extract
	cd $W/pcre2-$(PCRE2_V) && ./configure --prefix=/usr \
		--enable-pcre2-16		\
		--enable-pcre2-32		\
		--enable-jit			\
		--enable-pcre2grep-libz		\
		--enable-pcre2test-libreadline

	+ make -C $W/pcre2-$(PCRE2_V)
	+ make -C $W/pcre2-$(PCRE2_V) install

	$(call done)
