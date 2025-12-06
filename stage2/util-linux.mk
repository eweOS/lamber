$W/stage2.util-linux.extract: $W/UTIL_LINUX.download
	tar xf $W/$(UTIL_LINUX_FILE) -C $W
	$(call done)

$W/stage2.util-linux.patch: $W/stage2.util-linux.extract $W/stage2.patch \
	$(SRCDIR)/stage2/util-linux-0002-meson-create-executable-link-with-sf.patch

	patch -p1 -d $W/util-linux-$(UTIL_LINUX_V) < \
		$(SRCDIR)/stage2/util-linux-0002-meson-create-executable-link-with-sf.patch
	$(call done)

$W/stage2.util-linux: $W/stage2.util-linux.patch \
	$W/stage2.meson $W/stage2.pam

	ewe-meson $W/util-linux-$(UTIL_LINUX_V) $W/util-linux-build \
		-Dfs-search-path=/usr/bin:/usr/local/bin	\
		-Dlibuser=disabled				\
		-Dlibutempter=disabled				\
		-Dncurses=disabled				\
		-Dncursesw=enabled				\
		-Deconf=disabled				\
		-Dsystemd=disabled				\
		-Dcryptsetup=disabled				\
		-Dnls=disabled					\
		-Dbuild-bash-completion=disabled		\
		-Dbuild-exch=disabled				\
		-Dbuild-waitpid=disabled			\
		-Dbuild-col=disabled				\
		-Dbuild-setpriv=disabled			\
		-Dbuild-chfn-chsh=enabled			\
		-Dbuild-line=disabled				\
		-Dbuild-mesg=enabled				\
		-Dbuild-newgrp=enabled				\
		-Dbuild-vipw=enabled				\
		-Dbuild-write=enabled
	+ meson compile -C $W/util-linux-build
	+ meson install -C $W/util-linux-build

	$(call done)
