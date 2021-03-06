# $OpenBSD: Makefile,v 1.249 2015/10/24 09:10:35 robert Exp $

ONLY_FOR_ARCHS=		i386 amd64
DPB_PROPERTIES=		parallel

COMMENT=		Chromium browser

V=			46.0.2490.80
DISTNAME=		chromium-${V}
DISTFILES=		${DISTNAME}${EXTRACT_SUFX}

CATEGORIES=		www

HOMEPAGE=		https://www.chromium.org/Home

MAINTAINER=		Robert Nagy <robert@openbsd.org>

EXTRACT_SUFX=		.tar.xz

FLAVORS=		debug
FLAVOR?=

# BSD-like
PERMIT_PACKAGE_CDROM=	patents
PERMIT_PACKAGE_FTP =	Yes

MASTER_SITES=	https://commondatastorage.googleapis.com/chromium-browser-official/
MASTER_SITES0=	http://nerd.hu/distfiles/

#PATCHFILES+=		issue1236863006_160001.diff:0
#PATCH_DIST_STRIP=	-p1

MODULES=	lang/clang lang/python gcc4

MODCLANG_ARCHS=	*
MODCLANG_LANGS=	c++

MODPY_RUNDEP=	No

PATCHORIG=	.orig.port

WANTLIB += X11 Xext Xfixes Xrender Xss c cairo cups dbus-1 event
WANTLIB += execinfo expat fontconfig freetype gconf-2 gdk-x11-2.0
WANTLIB += gdk_pixbuf-2.0 glib-2.0 gobject-2.0 gtk-x11-2.0
WANTLIB += m pango-1.0 pangocairo-1.0
WANTLIB += png pthread
WANTLIB += xml2 xslt
WANTLIB += sndio
WANTLIB += Xcomposite
WANTLIB += estdc++>=17
WANTLIB += Xi Xtst
WANTLIB += Xdamage
WANTLIB += Xcursor Xrandr gio-2.0
WANTLIB += jpeg nspr4 nss3 nssutil3 smime3
WANTLIB += atk-1.0 gmodule-2.0

RUN_DEPENDS=	devel/xdg-utils \
		devel/desktop-file-utils \
		fonts/droid-fonts \
		graphics/libexif \
		x11/gnome/libgnome-keyring \
		x11/gtk+3 #,-guic
BUILD_DEPENDS=	archivers/bzip2 \
		devel/gperf \
		devel/bison \
		devel/flex \
		devel/yasm \
		shells/bash \
		sysutils/flock \
		sysutils/pciutils \
		x11/gnome/libgnome-keyring \
		devel/ninja \
		lang/gcc/4.9,-c++>=4.9,<4.10
LIB_DEPENDS=	devel/libexecinfo \
		security/nss \
		devel/gconf2 \
		textproc/libxslt \
		x11/gtk+2 \
		print/cups,-libs \
		lang/gcc/4.9,-libs>=4.9,<4.10

.include <bsd.own.mk>

# Set BUILDTYPE to Debug for a debug build
.if ${FLAVOR:Mdebug}
BUILDTYPE=	Debug
.else
BUILDTYPE=	Release
.endif

TEST_TARGET=	base_unittests

CONFIGURE_STYLE=none # prevent python MODULE from overriding do-build
CONFIGURE_ENV=	CPPFLAGS="-idirafter ${LOCALBASE}/include -idirafter ${X11BASE}/include" \
		LDFLAGS="-L${LOCALBASE}/lib -L${X11BASE}/lib" \
		GYP_GENERATORS=ninja

ALL_TARGET=	chrome

BUILDDIR=	${WRKSRC}/out/${BUILDTYPE}

GYP_DEFS=	-Duse_system_bzip2=1 \
		-Duse_system_libevent=1 \
		-Duse_system_libjpeg=1 \
		-Duse_system_libpng=1 \
		-Duse_system_libusb=0 \
		-Duse_system_libvpx=0 \
		-Duse_system_libxml=1 \
		-Duse_system_sqlite=0 \
		-Duse_system_yasm=1 \
		-Duse_system_zlib=0 \
		-Duse_system_ssl=0 \
		-Duse_system_icu=0 \
		-Ddisable_nacl=1 \
		-Dlinux_breakpad=0 \
		-Duse_allocator=none \
		-Dlinux_strip_binary=0 \
		-Dlinux_use_heapchecker=0 \
		-Denable_webrtc=0 \
		-Denable_one_click_signin=1 \
		-Duse_kerberos=0 \
		-Duse_sndio=1 \
		-Duse_aura=1 \
		-Dclang=1 \
		-Dclang_use_chrome_plugins=0 \
		-Dwerror= \
		-Dno_gc_sections=1 \
		-Ddisable_fatal_linker_warnings=1 \
		-Dv8_use_external_startup_data=0 \
		-Dlibraries_for_target='-lestdc++' \
		-DOS=openbsd

# Note: these keys are for OpenBSD use ONLY. For your own distribution,
# please get your own set of keys. It's free!
GYP_DEFS+=	-Dgoogle_api_key='AIzaSyA015yecfJyWi8UQpneQVrNzIKlxjv4MhI' \
		-Dgoogle_default_client_id='451220141585.apps.googleusercontent.com' \
		-Dgoogle_default_client_secret='nQcDyaBvDyCeDrsRqKIWSHJn' \
		-Dffmpeg_branding=Chrome \
		-Dproprietary_codecs=1

.if ${MACHINE_ARCH} == "i386"
CARCH=		i386
.elif ${MACHINE_ARCH} == "amd64"
CARCH=		x86_64
.endif

REL!=		uname -r
MAKE_ENV+=	CPATH=${LOCALBASE}/include/c++/${MODGCC4_VERSION}.3/bits/:${LOCALBASE}/include/c++/${MODGCC4_VERSION}.3/:${LOCALBASE}/include/c++/${MODGCC4_VERSION}.3/${CARCH}-unknown-openbsd${REL}/

.if ${FLAVOR:Mdebug}
GYP_DEFS+=	-Dremove_webcore_debug_symbols=1
MAKE_ENV+=	V=1
.endif

MODPY_ADJ_FILES=build/linux/unbundle/replace_gyp_files.py

pre-configure:
	@ln -sf ${MODPY_BIN} ${WRKDIR}/bin/python
.for _arch in x64 ia32
	@cp -pR ${WRKSRC}/third_party/ffmpeg/chromium/config/Chrome/linux/${_arch}/libavutil \
		${WRKSRC}/third_party/ffmpeg/chromium/config/Chrome/openbsd/${_arch}/libavutil
.endfor
	@mkdir -p ${WRKSRC}/media/audio/sndio
	@cp ${FILESDIR}/sndio_output.{cc,h} ${WRKSRC}/media/audio/sndio
	# XXX Create a missing html file to avoid a build failure (unused in the actual package)
	@touch ${WRKSRC}/chrome/test/data/webui/i18n_process_css_test.html

# gyp_chromium generates all the Makefiles from gyp
do-configure:
	cd ${WRKSRC} && \
		build/linux/unbundle/replace_gyp_files.py ${GYP_DEFS} && \
		env -i ${CONFIGURE_ENV} ${MODPY_BIN} build/gyp_chromium \
		${GYP_DEFS} "--depth=${WRKSRC}"

do-build:
	# Build all the resources as the first step to avoid build failures
	# due to internal dependency issues.
	@cd ${WRKSRC}/out/${BUILDTYPE} && \
	for _r in net_interfaces suggestions cacheinvalidation cacheinvalidation_proto_cpp \
	$$(ninja -t targets | grep 'resources: phony' | cut -d ':' -f1); do \
		cd ${WRKSRC} && env -i ${MAKE_ENV} ninja \
			-j ${MAKE_JOBS} -C out/${BUILDTYPE} $${_r}; \
	done
	@cd ${WRKSRC} && env -i ${MAKE_ENV} ninja \
		-j ${MAKE_JOBS} -C out/${BUILDTYPE} ${ALL_TARGET}

do-install:
	${INSTALL_DATA_DIR} ${PREFIX}/chrome
	${INSTALL_PROGRAM} ${BUILDDIR}/chrome ${PREFIX}/chrome
	${SUBST_PROGRAM} ${FILESDIR}/chrome ${PREFIX}/bin/chrome
	${INSTALL_MAN} ${BUILDDIR}/chrome.1 ${PREFIX}/man/man1

.for p in chrome_100_percent content_resources keyboard_resources resources
	${INSTALL_DATA} ${BUILDDIR}/${p}.pak ${PREFIX}/chrome
.endfor
	${INSTALL_DATA_DIR} ${PREFIX}/chrome/locales
	${INSTALL_DATA} ${BUILDDIR}/locales/* ${PREFIX}/chrome/locales
	${INSTALL_DATA} ${BUILDDIR}/*.png ${PREFIX}/chrome
	${INSTALL_DATA_DIR} ${PREFIX}/chrome/resources
	@cp -Rp ${BUILDDIR}/resources/* ${PREFIX}/chrome/resources
	@chown -R ${SHAREOWN}:${SHAREGRP} ${PREFIX}/chrome/resources
.for f in libexif.so protoc icudtl.dat mksnapshot
	${INSTALL_DATA} ${BUILDDIR}/${f} ${PREFIX}/chrome
.endfor
.for s in 22 24 48 64 128 256
	${INSTALL_DATA_DIR} ${PREFIX}/share/icons/hicolor/${s}x${s}/apps
	${INSTALL_DATA} ${WRKSRC}/chrome/app/theme/chromium/product_logo_${s}.png \
		${PREFIX}/share/icons/hicolor/${s}x${s}/apps/chrome.png
.endfor
	${INSTALL_DATA_DIR} ${PREFIX}/share/applications
	${INSTALL_DATA} ${FILESDIR}/chromium-browser.desktop \
		${PREFIX}/share/applications/chromium-browser.desktop

.include <bsd.port.mk>
