PKG_NAME = libmediainfo
PKG_VERS = 21.03
PKG_EXT = tar.gz
PKG_DIST_NAME = $(PKG_NAME)_$(PKG_VERS).$(PKG_EXT)
PKG_DIST_SITE = https://github.com/MediaArea/MediaInfoLib/archive/v$(PKG_VERS)
PKG_DIR = MediaInfoLib-$(PKG_VERS)/Project/GNU/Library

DEPENDS = cross/libzen cross/zlib

HOMEPAGE = https://mediaarea.net/en/MediaInfo
COMMENT  = MediaInfo is a convenient unified display of the most relevant technical and tag data for video and audio files.
LICENSE  = 2-Clause BSD

PRE_CONFIGURE_TARGET = libmediainfo_pre_configure
GNU_CONFIGURE = 1

CONFIGURE_ARGS = --enable-shared

include ../../mk/spksrc.cross-cc.mk

libmediainfo_pre_configure:
	$(RUN) ; ./autogen.sh
