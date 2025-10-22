$W/stage2.autotools: \
	$W/stage2.autoconf $W/stage2.automake $W/stage2.libtool	\
	$W/stage2.slibtool

	$(call done)

$W/stage2.base-devel: \
	$W/stage2.autotools $W/stage2.patch $W/stage2.file $W/stage2.perl \
	$W/stage2.bison $W/stage2.flex $W/stage2.git $W/stage2.pcre2	\
	$W/stage2.gettext-tiny $W/stage2.cmake $W/stage2.expat

	$(call done)
