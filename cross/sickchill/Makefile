PKG_NAME = SickChill
PKG_VERS = 2021.07.29
PKG_EXT = tar.gz
PKG_DIST_NAME = $(PKG_VERS).$(PKG_EXT)
PKG_DIST_SITE = https://github.com/SickChill/SickChill/archive/refs/tags
PKG_DIR = $(PKG_NAME)-$(PKG_VERS)

SC_GIT_BRANCH=master
SC_GIT_COMMIT_HASH=5f63ed027cd80bd85604885d67d3fef3e40f42c9
SC_GIT_COMMIT_BRANCH=$(PKG_VERS)

DEPENDS =

HOMEPAGE = https://sickchill.github.io/
COMMENT = Automatic Video Library Manager for TV Shows. It watches for new episodes of your favorite shows, and when they are posted it does its magic.
LICENSE = GPL

CONFIGURE_TARGET = nop
COMPILE_TARGET = nop
INSTALL_TARGET = sickchill_install

include ../../mk/spksrc.cross-cc.mk

.PHONY: sickchill_install
sickchill_install:
	mkdir -p $(STAGING_INSTALL_PREFIX)/share/$(PKG_NAME)
	tar -cf - -C $(WORK_DIR)/$(PKG_DIR) . | tar -xf - -C $(STAGING_INSTALL_PREFIX)/share/$(PKG_NAME)
	echo SC_GIT_BRANCH=${SC_GIT_BRANCH} > $(STAGING_INSTALL_PREFIX)/share/git_data
	echo SC_GIT_COMMIT_HASH=${SC_GIT_COMMIT_HASH} >> $(STAGING_INSTALL_PREFIX)/share/git_data
	echo SC_GIT_COMMIT_BRANCH=${SC_GIT_COMMIT_BRANCH} >> $(STAGING_INSTALL_PREFIX)/share/git_data
