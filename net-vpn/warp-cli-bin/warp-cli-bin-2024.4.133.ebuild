# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
inherit unpacker xdg-utils systemd

DESCRIPTION="Cloudflare warp-cli binary distribution"
HOMEPAGE="https://developers.cloudflare.com/warp-client"

MY_PN="cloudflare-warp"
MY_PV=$(ver_rs)
INDEX="1"
ARCH="amd64"

#
# when updating, find latest package by executing:
#
# `curl https://pkg.cloudflareclient.com/dists/focal/main/binary-amd64/Packages`
#
SRC_URI="https://pkg.cloudflareclient.com/pool/focal/main/c/${MY_PN}/${MY_PN}_${MY_PV}-${INDEX}_${ARCH}.deb"

SLOT="0"
#RESTRICT="mirror"
KEYWORDS="~arm64"
#IUSE=""
RDEPEND=""

DEPEND="${RDEPEND} sys-libs/glibc sys-apps/dbus net-firewall/nftables app-crypt/gnupg dev-util/desktop-file-utils sys-libs/libcap"

S="${WORKDIR}"

src_unpack() {

	unpack_deb ${A}

	cd "${WORKDIR}/usr/share/doc/cloudflare-warp" && unpack ./changelog.Debian.gz && rm -f ./changelog.Debian.gz
	cd "${WORKDIR}/usr/share/doc/cloudflare-warp" && unpack ./changelog.gz && rm -f ./changelog.gz

	#TODO check md5sums
	#die
}

src_install() {
	into /
	dobin bin/*

	# Taskbar desktop app
	insinto /etc/xdg/autostart
	doins ${WORKDIR}/etc/xdg/autostart/*

	# Systemd service
	#insinto /lib/systemd/system
	#doins ${WORKDIR}/lib/systemd/system/*
	systemd_dounit ${WORKDIR}/lib/systemd/system/warp-svc.service

	# User systemd service
	#insinto /usr/lib/systemd/user
	#doins ${WORKDIR}/usr/lib/systemd/user/*
	systemd_douserunit ${WORKDIR}/usr/lib/systemd/user/warp-taskbar.service

	# Taskbar desktop app
	insinto /usr/share/applications
	doins ${WORKDIR}/usr/share/applications/*

	# Icons
	insinto /usr/share/icons/hicolor/scalable/apps
	doins ${WORKDIR}/usr/share/icons/hicolor/scalable/apps/*

	# Images
	insinto /usr/share/warp/images
	doins ${WORKDIR}/usr/share/warp/images/*

	# Docs
	dodoc -r ${WORKDIR}/usr/share/doc/cloudflare-warp/*
}

pkg_postinst() {
	xdg_icon_cache_update
}

pkg_postrm() {
	xdg_icon_cache_update
}
