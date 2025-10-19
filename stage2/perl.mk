$W/stage2.perl.extract: $W/PERL.download
	tar xf $W/$(PERL_FILE) -C $W
	$(call done)

$W/stage2.perl: $W/stage2.perl.extract
	cd $W/perl-$(PERL_V) && env \
	BUILD_ZLIB=False CFLAGS="-D_GNU_SOURCE" HOSTCFLAGS="-D_GNU_SOURCE" \
		./configure.gnu \
		-des -Dprefix=/usr					\
		-Dvendorprefix=/usr					\
		-Dprivlib=/usr/share/perl5/core_perl			\
		-Darchlib=/usr/lib/perl5/$_baseversion/core_perl	\
		-Dsitelib=/usr/share/perl5/site_perl			\
		-Dsitearch=/usr/lib/perl5/$_baseversion/site_perl	\
		-Dvendorlib=/usr/share/perl5/vendor_perl		\
		-Dvendorarch=/usr/lib/perl5/$_baseversion/vendor_perl	\
		-Dman1dir=/usr/share/man/man1				\
		-Dman3dir=/usr/share/man/man3				\
		-Dinc_version_list=none					\
		-Dpager="/bin/less -I"					\
		-Dusethreads						\
		-Duseshrplib

	+ make -C $W/perl-$(PERL_V)
	+ make -C $W/perl-$(PERL_V) install

	sed -e '/(makepl_arg =>/   s/""/"INSTALLDIRS=site"/'	\
	    -e '/(mbuildpl_arg =>/ s/""/"installdirs=site"/'	\
		-i /usr/share/perl5/core_perl/CPAN/FirstTime.pm

	$(call done)
