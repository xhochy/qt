# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="4"
if [[ ${PV} == 4*9999 ]]; then
	QT_ECLASS="-edge"
fi
inherit qt4-build${QT_ECLASS}

DESCRIPTION="The DBus module for the Qt toolkit"
SLOT="4"
if [[ ${PV} != 4*9999 ]]; then
	KEYWORDS="~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 -sparc ~x86 ~x86-fbsd ~x86-freebsd ~amd64-linux ~ia64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~x64-solaris ~x86-solaris"
else
	KEYWORDS=""
fi
IUSE=""

DEPEND="~x11-libs/qt-core-${PV}[aqua=,c++0x=,qpa=,debug=]
	>=sys-apps/dbus-1.0.2"
RDEPEND="${DEPEND}"

pkg_setup() {
	QT4_TARGET_DIRECTORIES="
		src/dbus
		tools/qdbus/qdbus
		tools/qdbus/qdbusxml2cpp
		tools/qdbus/qdbuscpp2xml"
	QCONFIG_ADD="dbus dbus-linked"
	QCONFIG_DEFINE="QT_DBUS"

	if [[ ${PV} != 4*9999 ]]; then
		QT4_EXTRACT_DIRECTORIES="${QT4_TARGET_DIRECTORIES}
			include/QtCore
			include/QtDBus
			include/QtXml
			src/corelib
			src/xml"
	fi

	qt4-build${QT_ECLASS}_pkg_setup
}

src_configure() {
	myconf="${myconf} -dbus-linked"
	qt4-build${QT_ECLASS}_src_configure
}
