$W/stage2.libcap.extract: $W/LIBCAP.download
	tar xf $W/$(LIBCAP_FILE) -C $W
	$(call done)

LIBCAP_MAKEFLAGS := DYNAMIC=yes KERNEL_HEADERS=/usr/include lib=lib prefix=/usr
LIBCAP_MAKEFLAGS += sbindir=bin CC=clang HOSTCC=clang

$W/stage2.libcap: $W/stage2.libcap.extract $W/stage2.base-devel
	+ make -C $W/libcap-$(LIBCAP_V) $(LIBCAP_MAKEFLAGS)
	+ make -C $W/libcap-$(LIBCAP_V) $(LIBCAP_MAKEFLAGS) install
	$(call done)
