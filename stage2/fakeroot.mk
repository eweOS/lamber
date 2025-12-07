$W/stage2.fakeroot.extract: $W/FAKEROOT.download
	tar xf $W/$(FAKEROOT_FILE) -C $W
	$(call done)

$W/stage2.fakeroot.patch: $W/stage2.fakeroot.extract $W/stage2.patch \
	$(SRCDIR)/stage2/fakeroot-0001-define-SEND_GET_XATTR.patch \
	$(SRCDIR)/stage2/fakeroot-0002-configure-do-not-check-non-musl-symbols.patch

	patch -p1 -d $W/fakeroot-upstream-$(FAKEROOT_V) \
		< $(SRCDIR)/stage2/fakeroot-0001-define-SEND_GET_XATTR.patch
	patch -p1 -d $W/fakeroot-upstream-$(FAKEROOT_V) \
		< $(SRCDIR)/stage2/fakeroot-0002-configure-do-not-check-non-musl-symbols.patch

	# We couldn't build the documentation, however in which case fakeroot
	# just fails to install.
	sed -i 's/SUBDIRS = .*//' \
		$W/fakeroot-upstream-$(FAKEROOT_V)/doc/Makefile.am

	$(call done)

$W/stage2.fakeroot: $W/stage2.fakeroot.patch \
	$W/stage2.util-linux $W/stage2.autotools $W/stage2.libcap

	cd $W/fakeroot-upstream-$(FAKEROOT_V) && autoreconf -fiv

	cd $W/fakeroot-upstream-$(FAKEROOT_V) && ./configure --prefix=/usr \
		--libdir=/usr/lib/libfakeroot	\
		--disable-static		\
		--with-ipc=sysv
	+ make -C $W/fakeroot-upstream-$(FAKEROOT_V)
	+ make -C $W/fakeroot-upstream-$(FAKEROOT_V) install

	$(call done)
