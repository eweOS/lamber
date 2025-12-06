$W/stage2.pam.extract: $W/PAM.download
	tar xf $W/$(PAM_FILE) -C $W
	$(call done)

$W/stage2.pam: $W/stage2.pam.extract \
	$W/stage2.flex $W/stage2.utmps $W/stage2.meson

	# https://github.com/linux-pam/linux-pam/issues/922
	# As for 1.7.1 release, pam doesn't provide distinct version scripts
	# for each module, even some modules may miss some of the symbols.
	#
	# However, mold (and ld.lld) considers version assignments to undefined
	# symbols as errors, differing from GNU ld. Silent the warnings with
	# --undefined-version until
	# https://github.com/linux-pam/linux-pam/pull/928 lands in a release.
	env LDFLAGS="-Wl,--undefined-version" ewe-meson \
		$W/linux-pam-$(PAM_V) $W/linux-pam-build \
		-Dlogind=disabled		\
		-Dnis=disabled			\
		-Deconf=disabled		\
		-Dselinux=disabled		\
		-Dpam_userdb=disabled		\
		-Daudit=disabled		\
		-Ddocs=disabled			\
		-Di18n=disabled			\
		-Delogind=disabled
	+ meson compile -C $W/linux-pam-build
	+ meson install -C $W/linux-pam-build

	$(call done)
