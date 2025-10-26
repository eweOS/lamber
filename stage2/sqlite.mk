$W/stage2.sqlite.extract: $W/SQLITE.download
	tar xf $W/$(SQLITE_FILE) -C $W
	$(call done)

SQLITE_FLAGS	:= -DSQLITE_ENABLE_COLUMN_METADATA=1
SQLITE_FLAGS	+= -DSQLITE_ENABLE_UNLOCK_NOTIFY
SQLITE_FLAGS	+= -DSQLITE_SECURE_DELETE=1
SQLITE_FLAGS	+= -DSQLITE_ENABLE_DBSTAT_VTAB=1
SQLITE_FLAGS	+= -DSQLITE_ENABLE_FTS3=1
SQLITE_FLAGS	+= -DSQLITE_ENABLE_RTREE=1

$W/stage2.sqlite: $W/stage2.sqlite.extract
	cd $W/sqlite-autoconf-$(SQLITE_V) && env CFLAGS="$(SQLITE_FLAGS)" && \
		./configure --prefix=/usr \
			--disable-static

	+ make -C $W/sqlite-autoconf-$(SQLITE_V)
	+ make -C $W/sqlite-autoconf-$(SQLITE_V) install

	$(call done)
