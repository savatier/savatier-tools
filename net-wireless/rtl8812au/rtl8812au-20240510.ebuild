# Copyright 1999-2025 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8
inherit linux-mod-r1

COMMIT="b44d288f423ede0fc7cdbf92d07a7772cd727de4"

DESCRIPTION="Realtek 8812AU USB WiFi module for Linux kernel"
HOMEPAGE="https://github.com/aircrack-ng/rtl8812au"
SRC_URI="https://github.com/aircrack-ng/rtl8812au/archive/${COMMIT}.zip -> rtl8812au-${PV}.zip"

SLOT="0"

LICENSE="GPL-2"
KEYWORDS="~amd64"

DEPEND="virtual/linux-sources
	app-arch/unzip"
RDEPEND=""

S="${WORKDIR}/rtl8812au-${COMMIT}"

#MODULE_NAMES="88XXau(net/wireless)"
#BUILD_TARGETS="all"
#BUILD_TARGET_ARCH="${ARCH}"

src_unpack() {
	unpack "${A}"
	cd "${S}"
}

pkg_setup() {
	linux-mod-r1_pkg_setup
}

src_compile(){
	local modlist=(88XXau=net/wireless)
	linux-mod-r1_src_compile
}

src_install() {
	linux-mod-r1_src_install
}

pkg_postinst() {
	linux-mod-r1_pkg_postinst
}

