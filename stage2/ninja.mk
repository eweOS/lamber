$W/stage2.ninja.extract: $W/NINJA.download
	tar xf $W/$(NINJA_FILE) -C $W
	$(call done)

$W/stage2.ninja: $W/stage2.ninja.extract $W/stage2.python
	+ cd $W/ninja-$(NINJA_V) && ./configure.py --bootstrap

	install -Dm0755 $W/ninja-$(NINJA_V)/ninja /usr/bin/ninja

	$(call done)
