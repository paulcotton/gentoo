# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=5

# ebuild generated by hackport 0.4.6.9999
#hackport: flags: +small_base

CABAL_FEATURES="bin test-suite"
inherit autotools eutils haskell-cabal

DESCRIPTION="Alex is a tool for generating lexical analysers in Haskell"
HOMEPAGE="http://www.haskell.org/alex/"
SRC_URI="https://hackage.haskell.org/package/${P}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 ~ia64 ~ppc ~ppc64 ~sparc x86"
IUSE="doc"

RDEPEND=">=dev-haskell/quickcheck-2:2=
	>=dev-lang/ghc-7.4.1:=
"
DEPEND="${RDEPEND}
	>=dev-haskell/cabal-1.8
	doc? ( ~app-text/docbook-xml-dtd-4.2
		app-text/docbook-xsl-stylesheets
		>=dev-libs/libxslt-1.1.2 )
"

src_prepare() {
	# drop depend on itself and happy, otherwise cabal tries to regenerate it
	rm src/{Scan.x,Parser.y} || die

	for f in Scan Parser; do
		mv "${S}/dist/build/alex/alex-tmp/$f.hs" "${S}"/src/ || die
	done

	if use doc; then
		cd "${S}/doc/"
		eautoreconf
	fi
}

src_configure() {
	# make sure we don't accidentally use those
	# installed in system
	haskell-cabal_src_configure \
		--with-alex=false \
		--with-happy=false \
		--flag=small_base

	if use doc; then
		cd "${S}/doc/"
		econf
	fi
}

src_compile() {
	cabal_src_compile

	if use doc; then
		emake -C "${S}/doc/" -j1
	fi
}

src_test() {
	# workaround https://github.com/haskell/cabal/issues/2398
	emake -k -C tests all
}

src_install() {
	cabal_src_install

	if use doc; then
		doman "${S}/doc/alex.1"
		dohtml -r "${S}/doc/alex/"
	fi
	dodoc README
}
