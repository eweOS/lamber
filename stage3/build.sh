#!/usr/bin/bash

die() {
	echo "$1" 1>&2
	exit 1
}

repo="$1"
package="$2"

stage3dir="$(realpath $(dirname $0))"

[ -d build-"$package" ] ||
	git clone "$repo" -b "$package" build-"$package" ||
	die "failed to checkout branch \"$package\" from \"$repo\""

cd build-"$package"


if [ -f "$stage3dir/$package.patch" ]; then
	patch -p1 < "$stage3dir/$package.patch" || die "failed to apply patch"
	echo "Applied $stage3dir/$package.patch"
fi

makepkg -dA --nocheck || die "failed to build package"

ls -lh *.pkg.*

mkdir -p ../built-packages
mv *.pkg.* ../built-packages
