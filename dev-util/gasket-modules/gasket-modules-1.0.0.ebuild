# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit linux-mod-r1 udev

DESCRIPTION="Coral Gasket Driver"
HOMEPAGE="https://github.com/google/gasket-driver"

MY_COMMIT="97aeba584efd18983850c36dcf7384b0185284b3"

SRC_URI="https://github.com/google/gasket-driver/archive/${MY_COMMIT}.tar.gz -> ${P}-${MY_COMMIT}.tar.gz"
S="${WORKDIR}/gasket-driver-${MY_COMMIT}"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64"

src_compile() {
	local modlist=( {gasket,apex}=misc )
	local modargs=( KERN_DIR="${KV_OUT_DIR}" KERN_VER="${KV_FULL}" )
	linux-mod-r1_src_compile
}

src_install() {
	linux-mod-r1_src_install
	insinto /usr/lib/modules-load.d/
}

pkg_postinst() {
	linux-mod_pkg_postinst
	udev_reload
}

pkg_postrm() {
	linux-mod_pkg_postrm
	udev_reload
}
