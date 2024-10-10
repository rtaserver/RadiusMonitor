include $(TOPDIR)/rules.mk

PKG_NAME:=luci-app-radius-monitor
PKG_VERSION:=2.3
PKG_RELEASE:=beta
PKG_MAINTAINER:=Maizil <maizilpc7@gmail.com>

PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)

include $(INCLUDE_DIR)/package.mk

define Package/$(PKG_NAME)
    CATEGORY:=LuCI
    SUBMENU:=3. Applications
    TITLE:=LuCI support for Radius Chilli
    PKGARCH:=all
    DEPENDS:=+luci +luci-base +git +git-http +libc +php8
endef

define Package/$(PKG_NAME)/description
    A LuCI support for Radius Chilli
endef

define Build/Prepare
endef

define Build/Configure
endef

define Build/Compile
endef

define Package/$(PKG_NAME)/preinst
endef

define Package/$(PKG_NAME)/postinst
endef

define Package/$(PKG_NAME)/install
endef

include $(TOPDIR)/feeds/luci/luci.mk

$(eval $(call BuildPackage,$(PKG_NAME)))
