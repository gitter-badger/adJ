# $OpenBSD$
# This port is released to the public domain. 2014
#
COMMENT=	"Bible study tool with modules from Sword project"

V=		3.2.1
DISTNAME=	xiphos-${V}
CATEGORIES=	textproc misc
PKGNAME=	${DISTNAME}
HOMEPAGE=	http://xiphos.org
MAINTAINER=	Vladimir T�mara Pati�o <vtamara@pasosdejesus.org>

MASTER_SITES=	${MASTER_SITE_SOURCEFORGE:=gnomesword/Xiphos/${V}/}
	
DISTFILES=	${DISTNAME}.tar.gz


#GPL
PERMIT_PACKAGE_CDROM=	Yes

#MODULES =       devel/waf  

#CONFIGURE_ARGS += --enable-gtkhtml

CFLAGS += -I/usr/local/include/ossp/
LDFLAGS += -I/usr/local/include/ossp/ -L/usr/local/lib

CONFIGURE_ENV+= CPPFLAGS="-I${LOCALBASE}/include -I/usr/local/include/ossp/ -L/usr/local/lib" 
MAKE_ENV += LD_PRELOAD=/usr/local/lib/python2.7/site-packages/libxml2mod.so

BUILD_DEPENDS=	textproc/intltool converters/libiconv textproc/sword www/gtkhtml3 textproc/clucene devel/libglade2 x11/gnome/doc-utils textproc/libxml devel/glib2 x11/gtk+2  x11/dbus-glib devel/libgsf devel/pango devel/atk graphics/cairo  graphics/png textproc/enchant devel/gconf2 devel/ORBit2 devel/pcre archivers/bzip2 net/curl devel/libidn www/webkit sysutils/e2fsprogs

RUN_DEPENDS+= 	converters/libiconv textproc/sword www/gtkhtml3 textproc/clucene devel/libglade2 x11/gnome/doc-utils textproc/libxml devel/glib2 x11/gtk+2  x11/dbus-glib devel/libgsf devel/pango devel/atk graphics/cairo  graphics/png textproc/enchant devel/gconf2 devel/ORBit2 devel/pcre archivers/bzip2 net/curl devel/libidn www/webkit sysutils/e2fsprogs

WANTLIB=	X11 c m stdc++ ssl

# compilacion con waf de py-cairo
do-configure:
	cd ${WRKSRC} && env PYTHON=${MODPY_BIN} \
		LDFLAGS="$$(python${MODPY_VERSION}-config --libs)" \
		${MODPY_BIN} ./waf configure

do-build:
	cd ${WRKBUILD} && ${MODPY_BIN} ./waf build

do-install:
	cd ${WRKBUILD} && ${MODPY_BIN} ./waf install

.include <bsd.port.mk>
