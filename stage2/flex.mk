$W/stage2.flex.extract: $W/FLEX.download
	tar xf $W/$(FLEX_FILE) -C $W

	$(call done)

$W/stage2.flex: $W/stage2.flex.extract $W/stage2.bison
	cd $W/flex-$(FLEX_V) && ./configure --prefix=/usr

	+ make -C $W/flex-$(FLEX_V)
	+ make -C $W/flex-$(FLEX_V) install

	$(call done)
