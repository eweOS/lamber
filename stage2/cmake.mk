$W/stage2.cmake.extract: $W/CMAKE.download
	tar xf $W/$(CMAKE_FILE) -C $W

	$(call done)

$W/stage2.cmake.patch: $W/stage2.cmake.extract $W/stage2.patch \
	$(SRCDIR)/stage2/cmake-0001-detect-eweOS.patch

	patch -p1 -d $W/cmake-$(CMAKE_V) < \
		$(SRCDIR)/stage2/cmake-0001-detect-eweOS.patch

	$(call done)

$W/stage2.cmake: $W/stage2.cmake.patch $W/stage2.os-release
	cd $W/cmake-$(CMAKE_V) && ./bootstrap --prefix=/usr

	+ make -C $W/cmake-$(CMAKE_V)
	+ make -C $W/cmake-$(CMAKE_V) install

	$(call done)
