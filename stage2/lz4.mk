$W/stage2.lz4.extract: $W/LZ4.download
	tar xf $W/$(LZ4_FILE) -C $W
	$(call done)

$W/stage2.lz4: $W/stage2.lz4.extract
	+ make -C $W/lz4-$(LZ4_V)/lib PREFIX=/usr
	+ make -C $W/lz4-$(LZ4_V)/programs PREFIX=/usr lz4 lz4c

	+ make -C $W/lz4-$(LZ4_V) PREFIX=/usr install

	$(call done)
