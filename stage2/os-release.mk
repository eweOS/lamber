# We should probably move this to stage1/filesystem

$W/stage2.os-release: $(SRCDIR)/stage2/os-release
	install -Dm644 $(SRCDIR)/stage2/os-release /etc/os-release

	$(call done)
