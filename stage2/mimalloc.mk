$W/stage2.mimalloc.extract: $W/MIMALLOC.download
	tar xf $W/$(MIMALLOC_FILE) -C $W
	$(call done)

$W/stage2.mimalloc: $W/stage2.mimalloc.extract $W/stage2.cmake
	cmake -B $W/mimalloc-build -S $W/mimalloc-$(MIMALLOC_V) \
		-DCMAKE_INSTALL_PREFIX=/usr	\
		-DMI_BUILD_STATIC=OFF		\
		-DMI_BUILD_OBJECT=OFF		\
		-DMI_INSTALL_TOPLEVEL=ON

	+ cmake --build $W/mimalloc-build
	+ cmake --install $W/mimalloc-build

	$(call done)
