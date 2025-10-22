$W/stage2.gettext-tiny.extract: $W/GETTEXT.download
	tar xf $W/$(GETTEXT_FILE) -C $W

	$(call done)

GETTEXT_TINY_FLAGS	:= LIBINTL=MUSL prefix=/usr

$W/stage2.gettext-tiny: $W/stage2.gettext-tiny.extract
	+ make $(GETTEXT_TINY_FLAGS) -C $W/gettext-tiny-$(GETTEXT_COMMIT)
	+ make $(GETTEXT_TINY_FLAGS) -C $W/gettext-tiny-$(GETTEXT_COMMIT) \
		install

	$(call done)
