include $(TOPDIR)/rules.mk

PKG_NAME:=luci-app-radius-monitor
PKG_VERSION:=1.2
PKG_MAINTAINER:=Maizil <maizilpc7@gmail.com>
LUCI_TITLE:=LuCI support for Radius Chilli
LUCI_PKGARCH:=all
LUCI_DEPENDS:=+git +git-http +unzip +dos2unix \
+libc +php8 +php8-fastcgi +php8-fpm +coreutils-stat +zoneinfo-asia +php8-cgi \
+php8-cli +php8-mod-bcmath +php8-mod-calendar +php8-mod-ctype +php8-mod-curl +php8-mod-dom +php8-mod-exif \
+php8-mod-fileinfo +php8-mod-filter +php8-mod-gd +php8-mod-iconv +php8-mod-intl +php8-mod-mbstring +php8-mod-mysqli \
+php8-mod-mysqlnd +php8-mod-opcache +php8-mod-pdo +php8-mod-pdo-mysql +php8-mod-phar +php8-mod-session \
+php8-mod-xml +php8-mod-xmlreader +php8-mod-xmlwriter +php8-mod-zip +libopenssl-legacy \
+mariadb-server +mariadb-server-extra +mariadb-client +mariadb-client-extra +libmariadb +nano \
+freeradius3 +freeradius3-common +freeradius3-default +freeradius3-mod-always +freeradius3-mod-attr-filter \
+freeradius3-mod-chap +freeradius3-mod-detail +freeradius3-mod-digest +freeradius3-mod-eap \
+freeradius3-mod-eap-gtc +freeradius3-mod-eap-md5 +freeradius3-mod-eap-mschapv2 +freeradius3-mod-eap-peap \
+freeradius3-mod-eap-pwd +freeradius3-mod-eap-tls +freeradius3-mod-eap-ttls +freeradius3-mod-exec \
+freeradius3-mod-expiration +freeradius3-mod-expr +freeradius3-mod-files +freeradius3-mod-logintime \
+freeradius3-mod-mschap +freeradius3-mod-pap +freeradius3-mod-preprocess +freeradius3-mod-radutmp \
+freeradius3-mod-realm +freeradius3-mod-sql +freeradius3-mod-sql-mysql +freeradius3-mod-sqlcounter \
+freeradius3-mod-unix +freeradius3-utils +libfreetype +wget-ssl +curl +unzip +tar +zoneinfo-asia +coova-chilli

PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)

include $(INCLUDE_DIR)/package.mk

define Package/$(PKG_NAME)/description
    Dukungan LuCI untuk Radius Chilli
endef

define Build/Prepare
    $(CP) $(CURDIR)/root $(PKG_BUILD_DIR)
    $(CP) $(CURDIR)/luasrc $(PKG_BUILD_DIR)
endef

define Build/Configure
endef

define Build/Compile
endef

define Package/$(PKG_NAME)/conffiles
endef

define Package/$(PKG_NAME)/preinst
#!/bin/sh
    cp -rf "/usr/share/hotspotlogin" "/tmp/hotspotlogin" >/dev/null 2>&1
    exit 0
endef

define Package/$(PKG_NAME)/postinst
endef

define Package/$(PKG_NAME)/prerm
#!/bin/sh
    cp -rf "/usr/share/hotspotlogin" "/tmp/hotspotlogin" >/dev/null 2>&1
    exit 0
endef

define Package/$(PKG_NAME)/postrm
#!/bin/sh
    rm -rf /www/RadiusMonitor >/dev/null 2>&1
    rm -rf /www/raddash >/dev/null 2>&1
    rm -rf /www/hotspotlogin >/dev/null 2>&1
    rm -rf /usr/share/hotspotlogin >/dev/null 2>&1
    exit 0
endef

define Package/$(PKG_NAME)/install
    $(CP) $(PKG_BUILD_DIR)/root/* $(1)/
    $(CP) $(PKG_BUILD_DIR)/luasrc/* $(1)/usr/lib/lua/luci/
endef

include $(TOPDIR)/feeds/luci/luci.mk

$(eval $(call BuildPackage,$(PKG_NAME)))
