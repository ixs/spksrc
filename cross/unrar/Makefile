PKG_NAME = unrar
PKG_VERS = 6.0.1
PKG_EXT = tar.gz
PKG_DIST_NAME = $(PKG_NAME)src-$(PKG_VERS).$(PKG_EXT)
PKG_DIST_SITE = https://www.rarlab.com/rar
PKG_DIR = $(PKG_NAME)

DEPENDS =

HOMEPAGE = https://rarlab.com
COMMENT  = Extract files from rar archives.
LICENSE  = freeware

CONFIGURE_TARGET = nop
INSTALL_TARGET = unrar_install

include ../../mk/spksrc.cross-cc.mk

.PHONY: unrar_install
unrar_install:
	$(RUN) $(MAKE) install DESTDIR=$(STAGING_INSTALL_PREFIX)
