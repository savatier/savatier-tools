# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_9 python3_10 python3_11 python3_12 python3_13 )

inherit distutils-r1

DESCRIPTION="Easy OpenAPI specs and Swagger UI for your Flask API"
HOMEPAGE="https://github.com/flasgger/flasgger"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~arm64 ~x86"

DEPEND="${PYTHON_DEPS}
	dev-python/flask[${PYTHON_USEDEP}]
	dev-python/pyyaml[${PYTHON_USEDEP}]
	dev-python/jsonschema[${PYTHON_USEDEP}]
	dev-python/six[${PYTHON_USEDEP}]
	dev-python/mistune[${PYTHON_USEDEP}]
	dev-python/werkzeug[${PYTHON_USEDEP}]"
RDEPEND="${DEPEND}"
