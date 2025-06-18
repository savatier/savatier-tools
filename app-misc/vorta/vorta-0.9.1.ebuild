EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{8..13} pypy3 )
inherit distutils-r1

distutils_enable_pep517

DESCRIPTION=" Desktop Backup Client for Borg Backup"
HOMEPAGE="https://github.com/borgbase/vorta"

SRC_URI="https://github.com/borgbase/${PN}/archive/refs/tags/v${PV}.zip -> ${P}.zip"

KEYWORDS="~amd64"
SLOT="0"
IUSE=""

# hydrus itself is WTFPL
# icons included are CC-BY-2.5
LICENSE="GPL-3"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

# RDEPEND is sorted as such:
# - No specific requirements
# - Specific version or slot
RDEPEND="
	${PYTHON_DEPS}
	$(python_gen_cond_dep '
        dev-python/peewee
        dev-python/paramiko
        dev-python/python-dateutil
        dev-python/secretstorage
        dev-python/psutil
        dev-python/llfuse
        dev-python/appdirs
		dev-python/PyQt6
    ')
    app-backup/borgbackup
"
BDEPEND="
	${RDEPEND}
"

python_install() {
    distutils-r1_python_install

    install -Dm644 package/icon-symbolic.svg "${ED}/usr/share/icons/hicolor/symbolic/apps/com.borgbase.Vorta-symbolic.svg"
    install -Dm644 src/vorta/assets/metadata/com.borgbase.Vorta.desktop -t "${ED}/usr/share/applications"
}
