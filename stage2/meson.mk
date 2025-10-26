# I'm really tired of dealing with these Python dependencies. Let's simply
# install a mesonbuild with pip when all its binary dependencies are met.

$W/stage2.meson: $W/stage2.ninja $W/stage2.python \
	$(SRCDIR)/stage2/meson-ewe-meson
	pip3 install meson==$(MESON_V)

	install -Dm755 $(SRCDIR)/stage2/meson-ewe-meson /usr/bin/ewe-meson

	$(call done)
