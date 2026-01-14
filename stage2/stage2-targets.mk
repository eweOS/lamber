$W/stage2.autotools: \
	$W/stage2.autoconf $W/stage2.automake $W/stage2.libtool	\
	$W/stage2.slibtool

	$(call done)

$W/stage2.base-devel: \
	$W/stage2.autotools $W/stage2.patch $W/stage2.file $W/stage2.perl \
	$W/stage2.bison $W/stage2.flex $W/stage2.git $W/stage2.pcre2	\
	$W/stage2.gettext-tiny $W/stage2.cmake $W/stage2.expat

	$(call done)

$W/stage2: \
	$W/stage2.fakeroot $W/stage2.file $W/stage2.gettext-tiny	\
	$W/stage2.gnupg $W/stage2.gpgme $W/stage2.pacman		\
	$W/stage2.libassuan $W/stage2.libbz2 $W/stage2.libffi 		\
	$W/stage2.libgcrypt $W/stage2.libgpg-error $W/stage2.libksba	\
	$W/stage2.libudev-zero $W/stage2.lz4 $W/stage2.npth		\
	$W/stage2.pam $W/stage2.pinentry $W/stage2.skalibs		\
	$W/stage2.util-linux $W/stage2.utmps $W/stage2.base-devel	\
	$W/stage2.mimalloc

	$(call done)
