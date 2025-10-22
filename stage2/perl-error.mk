$W/stage2.perl-error.extract: $W/PERL_ERROR.download
	tar xf $W/$(PERL_ERROR_FILE) -C $W

	$(call done)

$W/stage2.perl-error: $W/stage2.perl-error.extract $W/stage2.perl
	cd $W/Error-$(PERL_ERROR_V) && perl Makefile.PL INSTALLDIRS=vendor

	+ make -C $W/Error-$(PERL_ERROR_V)
	+ make -C $W/Error-$(PERL_ERROR_V) install

	$(call done)
