$W/stage2.expat.extract: $W/EXPAT.download
	tar xf $W/$(EXPAT_FILE) -C $W

	$(call done)

$W/stage2.expat: $W/stage2.expat.extract $W/stage2.cmake
	cmake -S $W/expat-$(EXPAT_V) -B $W/build-expat \
		-DCMAKE_INSTALL_PREFIX=/usr	\
		-DCMAKE_BUILD_TYPE=None		\
		-W no-dev

	+ cmake --build $W/build-expat
	+ cmake --install $W/build-expat

	$(call done)
