$W/stage2.file.extract: $W/FILE.download
	tar xf $W/$(FILE_FILE) -C $W

	$(call done)

$W/stage2.file: $W/stage2.file.extract
	cd $W/file-$(FILE_V) && ./configure --prefix=/usr \
		--datadir=/usr/share/file

	+ make -C $W/file-$(FILE_V)
	+ make -C $W/file-$(FILE_V) install

	$(call done)
