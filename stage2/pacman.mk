$W/stage2.pacman.extract: $W/PACMAN.download
	tar xf $W/$(PACMAN_FILE) -C $W
	$(call done)

$W/stage2.pacman.patch: $W/stage2.pacman.extract $W/stage2.patch \
	$(SRCDIR)/stage2/pacman-0001-fix-typo.patch		\
	$(SRCDIR)/stage2/pacman-0002-rust-ltoflags.patch

	patch -p1 -d $W/pacman-v$(PACMAN_V) < \
		$(SRCDIR)/stage2/pacman-0001-fix-typo.patch
	patch -p1 -d $W/pacman-v$(PACMAN_V) < \
		$(SRCDIR)/stage2/pacman-0002-rust-ltoflags.patch

	# Allow root to build packages
	sed -i -e 's/EUID == 0/EUID == -1/' \
		$W/pacman-v$(PACMAN_V)/scripts/makepkg.sh.in

	$(call done)

MAKEPKG_CFLAGS_x86_64		:= -fno-plt -march=x86-64
MAKEPKG_CFLAGS_x86_64		+= -fstack-clash-protection -fcf-protection
MAKEPKG_CFLAGS_aarch64		:= -fno-plt -march=armv8-a
MAKEPKG_CFLAGS_riscv64		:= -march=rv64gc
MAKEPKG_CFLAGS_loongarch64	:= -march=la64v1.0
MAKEPKG_CFLAGS	:= -Os -pipe $(MAKEPKG_FLAGS_$(CARCH))

MAKEPKG_LTO_x86_64	:= lto
MAKEPKG_LTO_aarch64	:= lto
MAKEPKG_LTO_riscv64	:= !lto
MAKEPKG_LTO_loongarch64	:= !lto
MAKEPKG_LTO	:= $(MAKEPKG_LTO_$(CARCH))

MAKEPKG_RUSTARCH_x86_64		:= x86_64
MAKEPKG_RUSTARCH_aarch64	:= aarch64
MAKEPKG_RUSTARCH_riscv64	:= rv64gc
MAKEPKG_RUSTARCH_loongarch64	:= loongarch64
MAKEPKG_RUSTARCH	:= $(MAKEPKG_RUSTARCH_$(CARCH))

$W/stage2.pacman: $W/stage2.pacman.extract $W/stage2.base-devel \
	$W/stage2.meson $W/stage2.ninja $W/stage2.gpgme		\
	$(SRCDIR)/stage2/pacman-function_dinit.sh		\
	$(SRCDIR)/stage2/pacman-function_license.sh		\
	$(SRCDIR)/stage2/pacman-function_patch.sh		\
	$(SRCDIR)/stage2/pacman-function_pick.sh		\
	$(SRCDIR)/stage2/pacman-function_sysutils.sh		\
	$(SRCDIR)/stage2/pacman-pacman.conf			\
	$(SRCDIR)/stage2/pacman-makepkg.conf

	ewe-meson $W/pacman-v$(PACMAN_V) $W/pacman-build \
		-Dscriptlet-shell=/usr/bin/bash		\
		-Dldconfig=/usr/bin/ldconfig		\
		-Ddoc=disabled

	+ meson compile -C $W/pacman-build

	+ meson install -C $W/pacman-build
	install -Dm644 $(SRCDIR)/stage2/pacman-function_dinit.sh	\
		$(SRCDIR)/stage2/pacman-function_license.sh		\
		$(SRCDIR)/stage2/pacman-function_patch.sh		\
		$(SRCDIR)/stage2/pacman-function_pick.sh		\
		$(SRCDIR)/stage2/pacman-function_sysutils.sh		\
		-t /usr/share/makepkg/
	install -Dm644 $(SRCDIR)/stage2/pacman-pacman.conf /etc/pacman.conf
	sed $(SRCDIR)/stage2/pacman-makepkg.conf \
		-e "s|@@BUILD_GEN_CFLAGS@@|$(MAKEPKG_CFLAGS)|g"		\
		-e "s|@@BUILD_GEN_RUSTARCH@@|$(MAKEPKG_RUSTARCH)|g"	\
		-e "s|@@BUILD_GEN_LTO@@|$(MAKEPKG_LTO)|g" > /etc/makepkg.conf

	$(call done)
