# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{9..13} )

inherit distutils-r1 desktop

distutils_enable_pep517

DESCRIPTION="Official ProtonVPN Linux app"
HOMEPAGE="https://protonvpn.com https://github.com/ProtonVPN/linux-app"
SRC_URI="https://github.com/ProtonVPN/linux-app/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
KEYWORDS="~amd64"
SLOT="0"
IUSE="appindicator"
RESTRICT="primaryuri"

RDEPEND="
	x11-libs/gtk+:3
	dev-python/pygobject[${PYTHON_USEDEP}]
	dev-python/psutil[${PYTHON_USEDEP}]
	dev-python/pycairo[${PYTHON_USEDEP}]
	appindicator? ( dev-libs/libappindicator:3 )
	net-vpn/protonvpn-nm-lib[${PYTHON_USEDEP}]
"

DEPEND="${RDEPEND}"

S="${WORKDIR}/linux-app-${PV}"

DOCS=( README.md )

src_install() {
	domenu protonvpn.desktop
	doicon -s scalable protonvpn_gui/assets/icons/protonvpn-logo.png
	distutils-r1_src_install
}
