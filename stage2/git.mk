$W/stage2.git.extract: $W/GIT.download
	tar xf $W/$(GIT_FILE) -C $W

	$(call done)

GIT_FLAGS	= INSTALL_SYMLINKS=1 NO_PERL_CPAN_FALLBACKS=1 USE_LIBPCRE2=1
GIT_FLAGS	+= NO_REGEX=NeedsStartEnd CC=clang HOSTCC=clang
GIT_FLAGS	+= prefix='/usr' gitexecdir='/usr/lib/git-core'
GIT_FLAGS	+= perllibdir=$(shell perl -MConfig -wle 'print $$Config{installvendorlib}')

$W/stage2.git: $W/stage2.git.extract \
	$W/stage2.expat $W/stage2.perl $W/stage2.perl-error $W/stage2.pcre2 \
	$W/stage2.gettext-tiny

	+ make $(GIT_FLAGS) -C $W/git-$(GIT_V)
	+ make $(GIT_FLAGS) -C $W/git-$(GIT_V) install

	$(call done)
