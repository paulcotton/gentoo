# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=5

# ebuild generated by hackport 0.4.5.9999

CABAL_FEATURES="bin lib profile haddock hoogle hscolour"
inherit haskell-cabal

DESCRIPTION="A liberalised re-implementation of cpp, the C pre-processor"
HOMEPAGE="http://projects.haskell.org/cpphs/"
SRC_URI="https://hackage.haskell.org/package/${P}/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0/${PV}"
KEYWORDS="amd64 ~ia64 ~ppc ~ppc64 ~sparc x86"
IUSE=""

RDEPEND="dev-haskell/old-locale:=[profile?]
	dev-haskell/old-time:=[profile?]
	>=dev-haskell/polyparse-1.9:=[profile?]
	>=dev-lang/ghc-7.4.1:=
"
DEPEND="${RDEPEND}
	>=dev-haskell/cabal-1.6
"

src_prepare() {
	# https://ghc.haskell.org/trac/ghc/ticket/10667
	[[ $(ghc-version) == 7.10.1.20150630 ]] && replace-hcflags -g ''
	[[ $(ghc-version) == 7.10.2 ]] && replace-hcflags -g ''
}
