# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
inherit unpacker xdg-utils systemd

DESCRIPTION="Cloudflare warp-cli binary distribution"
HOMEPAGE="https://developers.cloudflare.com/warp-client"

MY_PN="cloudflare_warp"
MY_PV=$(ver_rs 1- '_')
INDEX="1"
ARCH="amd64"
BUILD="734c1ff709"

SRC_URI="https://pkg.cloudflareclient.com/uploads/${MY_PN}_${MY_PV}_${INDEX}_${ARCH}_${BUILD}.deb"

SLOT="0"
#RESTRICT="mirror"
KEYWORDS="~arm64"
#IUSE=""
RDEPEND=""

DEPEND="${RDEPEND}"
#DEPEND="${RDEPEND} sys-libs/glibc sys-apps/dbus app-arch/lz4 app-arch/zstd app-arch/lzma app-arch/xz-utils net-firewall/nftables dev-libs/libgpg-error"
DEPEND="${RDEPEND} sys-libs/glibc sys-apps/dbus net-firewall/nftables app-crypt/gnupg dev-util/desktop-file-utils sys-libs/libcap"

S="${WORKDIR}"

src_unpack() {
	unpack_deb ${A}
	cd "${WORKDIR}/usr/share/doc/cloudflare-warp" && unpack ./changelog.Debian.gz && rm -f ./changelog.Debian.gz
	cd "${WORKDIR}/usr/share/doc/cloudflare-warp" && unpack ./changelog.gz && rm -f ./changelog.gz

	#TODO check md5sums
	die
}

src_install() {
	into /
	dobin bin/*

	# Taskbar desktop app
	insinto /etc/xdg/autostart
	doins ${WORKDIR}/etc/xdg/autostart/*

	# Systemd service
	insinto /lib/systemd/system
	doins ${WORKDIR}/lib/systemd/system/*
	systemd_dounit warp-svc.service

	# User systemd service
	insinto /usr/lib/systemd/user
	doins ${WORKDIR}/usr/lib/systemd/user/*
	systemd_douserunit warp-taskbar.service

	# Taskbar desktop app
	insinto /usr/share/applications
	doins ${WORKDIR}/usr/share/applications/*

	# Icons
	insinto /usr/share/icons/hicolor/scalable/apps
	doins ${WORKDIR}/usr/share/icons/hicolor/scalable/apps/*

	# Docs
	dodoc -r ${WORKDIR}/usr/share/doc/cloudflare-warp/*
}

pkg_postinst() {
	xdg_icon_cache_update
}

pkg_postrm() {
	xdg_icon_cache_update
}
