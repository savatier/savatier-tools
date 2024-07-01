# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
inherit unpacker udev

DESCRIPTION="Idaxis binary driver for card reader"
HOMEPAGE=""

MY_PN="IdaxisLinuxInstaller"
MY_PV=$(ver_rs 1- '.')
MY_ZIP="${MY_PN}v${MY_PV}.zip"
MY_PATH="./Idaxis CCID v${MY_PV} Linux Installer Package/Generic-Debian/"
MY_DEB="idaxis_ccid_${MY_PV}-1_16Dec2021_amd64.deb"

INDEX="1"
ARCH="amd64"
BUILD="734c1ff709"

#SRC_URI="https://pkg.cloudflareclient.com/uploads/${MY_PN}_${MY_PV}_${INDEX}_${ARCH}_${BUILD}.deb"
SRC_URI="https://www.idaxis.com/Drivers/${MY_ZIP}"

SLOT="0"
#RESTRICT="mirror"
KEYWORDS="~arm64"
#IUSE=""
RDEPEND=""

DEPEND="${RDEPEND}"
#DEPEND="${RDEPEND} sys-libs/glibc sys-apps/dbus app-arch/lz4 app-arch/zstd app-arch/lzma app-arch/xz-utils net-firewall/nftables dev-libs/libgpg-error"
#DEPEND="${RDEPEND} sys-libs/glibc sys-apps/dbus net-firewall/nftables app-crypt/gnupg dev-util/desktop-file-utils sys-libs/libcap"

S="${WORKDIR}"

src_unpack() {

	#Unpack the zip
	unpack ${MY_ZIP}

	# unpack the deb to work dir
	unpack_deb "${MY_PATH}/${MY_DEB}"

}

src_install() {

	udev_newrules etc/udev/rules.d/92_pcscd_abcccid.rules 92_pcscd_abcccid.rules

	insinto /usr/lib64/readers/usb 
	doins -r usr/lib/pcsc/drivers/ifd-abcccid.bundle

	# hack to let binary driver find bundler and plist TODO -fix this
	dosym /usr/lib64/readers/usb/ifd-abcccid.bundle /usr/lib/pcsc/drivers/ifd-abcccid.bundle

}

pkg_postinst() {
	udev_reload
}

pkg_postrm() {
	udev_reload
}

