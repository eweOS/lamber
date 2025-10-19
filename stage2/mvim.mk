$W/stage2.mvim.extract: $W/MVIM.download
	tar xf $W/$(MVIM_FILE) -C $W

	$(call done)

$W/stage2.mvim: $W/stage2.mvim.extract
	+ make -C $W/mvim-$(MVIM_COMMIT)/src
	install -Dm755 $W/mvim-$(MVIM_COMMIT)/src/mvim /usr/local/bin/mvim

	$(call done)
