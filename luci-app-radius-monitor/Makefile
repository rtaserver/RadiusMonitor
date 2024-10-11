include $(TOPDIR)/rules.mk

LUCI_DEPENDS:=+luci +luci-base
EXTRA_DEPENDS:=+git +git-http +unzip +dos2unix +libc +php8 +php8-fastcgi +php8-fpm +coreutils-stat +zoneinfo-asia \
               +php8-cgi +php8-cli +php8-mod-bcmath +php8-mod-calendar +php8-mod-ctype +php8-mod-curl +php8-mod-dom +php8-mod-exif \
               +php8-mod-fileinfo +php8-mod-filter +php8-mod-gd +php8-mod-iconv +php8-mod-intl +php8-mod-mbstring +php8-mod-mysqli \
               +php8-mod-mysqlnd +php8-mod-opcache +php8-mod-pdo +php8-mod-pdo-mysql +php8-mod-phar +php8-mod-session +php8-mod-xml \
               +php8-mod-xmlreader +php8-mod-xmlwriter +php8-mod-zip +libopenssl-legacy +mariadb-server +mariadb-server-extra \
               +mariadb-client +mariadb-client-extra +libmariadb +nano +freeradius3 +freeradius3-common +freeradius3-default \
               +freeradius3-mod-always +freeradius3-mod-attr-filter +freeradius3-mod-chap +freeradius3-mod-detail +freeradius3-mod-digest \
               +freeradius3-mod-eap +freeradius3-mod-eap-gtc +freeradius3-mod-eap-md5 +freeradius3-mod-eap-mschapv2 +freeradius3-mod-eap-peap \
               +freeradius3-mod-eap-pwd +freeradius3-mod-eap-tls +freeradius3-mod-eap-ttls +freeradius3-mod-exec +freeradius3-mod-expiration \
               +freeradius3-mod-expr +freeradius3-mod-files +freeradius3-mod-logintime +freeradius3-mod-mschap +freeradius3-mod-pap \
               +freeradius3-mod-preprocess +freeradius3-mod-radutmp +freeradius3-mod-realm +freeradius3-mod-sql +freeradius3-mod-sql-mysql \
               +freeradius3-mod-sqlcounter +freeradius3-mod-unix +freeradius3-utils +libfreetype +wget-ssl +curl +unzip +tar +zoneinfo-asia \
               +coova-chilli

PKG_NAME:=luci-app-radius-monitor
PKG_VERSION:=3.0
PKG_MAINTAINER:=Maizil <maizilpc7@gmail.com>

PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)

include $(INCLUDE_DIR)/package.mk

define Package/$(PKG_NAME)/config
    config PACKAGE_git
        default y if PACKAGE_$(PKG_NAME)

    config PACKAGE_git-http
        default y if PACKAGE_$(PKG_NAME)

    config PACKAGE_dos2unix
        default y if PACKAGE_$(PKG_NAME)

    config PACKAGE_libc
        default y if PACKAGE_$(PKG_NAME)

    config PACKAGE_php8
        default y if PACKAGE_$(PKG_NAME)

    config PACKAGE_php8-fastcgi
        default y if PACKAGE_$(PKG_NAME)

    config PACKAGE_php8-fpm
        default y if PACKAGE_$(PKG_NAME)

    config PACKAGE_coreutils-stat
        default y if PACKAGE_$(PKG_NAME)

    config PACKAGE_zoneinfo-asia
        default y if PACKAGE_$(PKG_NAME)

    config PACKAGE_php8-cgi
        default y if PACKAGE_$(PKG_NAME)

    config PACKAGE_php8-cli
        default y if PACKAGE_$(PKG_NAME)

    config PACKAGE_php8-mod-bcmath
        default y if PACKAGE_$(PKG_NAME)

    config PACKAGE_php8-mod-calendar
        default y if PACKAGE_$(PKG_NAME)

    config PACKAGE_php8-mod-ctype
        default y if PACKAGE_$(PKG_NAME)

    config PACKAGE_php8-mod-curl
        default y if PACKAGE_$(PKG_NAME)

    config PACKAGE_php8-mod-dom
        default y if PACKAGE_$(PKG_NAME)

    config PACKAGE_php8-mod-exif
        default y if PACKAGE_$(PKG_NAME)

    config PACKAGE_php8-mod-fileinfo
        default y if PACKAGE_$(PKG_NAME)

    config PACKAGE_php8-mod-filter
        default y if PACKAGE_$(PKG_NAME)

    config PACKAGE_php8-mod-gd
        default y if PACKAGE_$(PKG_NAME)

    config PACKAGE_php8-mod-iconv
        default y if PACKAGE_$(PKG_NAME)

    config PACKAGE_php8-mod-intl
        default y if PACKAGE_$(PKG_NAME)

    config PACKAGE_php8-mod-mbstring
        default y if PACKAGE_$(PKG_NAME)

    config PACKAGE_php8-mod-mysqli
        default y if PACKAGE_$(PKG_NAME)

    config PACKAGE_php8-mod-mysqlnd
        default y if PACKAGE_$(PKG_NAME)

    config PACKAGE_php8-mod-opcache
        default y if PACKAGE_$(PKG_NAME)

    config PACKAGE_php8-mod-pdo
        default y if PACKAGE_$(PKG_NAME)

    config PACKAGE_php8-mod-pdo-mysql
        default y if PACKAGE_$(PKG_NAME)

    config PACKAGE_php8-mod-phar
        default y if PACKAGE_$(PKG_NAME)

    config PACKAGE_php8-mod-session
        default y if PACKAGE_$(PKG_NAME)

    config PACKAGE_php8-mod-xml
        default y if PACKAGE_$(PKG_NAME)

    config PACKAGE_php8-mod-xmlreader
        default y if PACKAGE_$(PKG_NAME)

    config PACKAGE_php8-mod-xmlwriter
        default y if PACKAGE_$(PKG_NAME)

    config PACKAGE_php8-mod-zip
        default y if PACKAGE_$(PKG_NAME)

    config PACKAGE_libopenssl-legacy
        default y if PACKAGE_$(PKG_NAME)

    config PACKAGE_mariadb-server
        default y if PACKAGE_$(PKG_NAME)

    config PACKAGE_mariadb-server-extra
        default y if PACKAGE_$(PKG_NAME)

    config PACKAGE_mariadb-client
        default y if PACKAGE_$(PKG_NAME)

    config PACKAGE_mariadb-client-extra
        default y if PACKAGE_$(PKG_NAME)

    config PACKAGE_libmariadb
        default y if PACKAGE_$(PKG_NAME)

    config PACKAGE_nano
        default y if PACKAGE_$(PKG_NAME)

    config PACKAGE_freeradius3
        default y if PACKAGE_$(PKG_NAME)

    config PACKAGE_freeradius3-common
        default y if PACKAGE_$(PKG_NAME)

    config PACKAGE_freeradius3-mod-always
        default y if PACKAGE_$(PKG_NAME)

    config PACKAGE_freeradius3-mod-attr-filter
        default y if PACKAGE_$(PKG_NAME)

    config PACKAGE_freeradius3-mod-chap
        default y if PACKAGE_$(PKG_NAME)

    config PACKAGE_freeradius3-mod-detail
        default y if PACKAGE_$(PKG_NAME)

    config PACKAGE_freeradius3-mod-digest
        default y if PACKAGE_$(PKG_NAME)

    config PACKAGE_freeradius3-mod-eap
        default y if PACKAGE_$(PKG_NAME)

    config PACKAGE_freeradius3-mod-eap-gtc
        default y if PACKAGE_$(PKG_NAME)

    config PACKAGE_freeradius3-mod-eap-md5
        default y if PACKAGE_$(PKG_NAME)

    config PACKAGE_freeradius3-mod-eap-mschapv2
        default y if PACKAGE_$(PKG_NAME)

    config PACKAGE_freeradius3-mod-eap-peap
        default y if PACKAGE_$(PKG_NAME)

    config PACKAGE_freeradius3-mod-eap-pwd
        default y if PACKAGE_$(PKG_NAME)

    config PACKAGE_freeradius3-mod-eap-tls
        default y if PACKAGE_$(PKG_NAME)

    config PACKAGE_freeradius3-mod-eap-ttls
        default y if PACKAGE_$(PKG_NAME)

    config PACKAGE_freeradius3-mod-exec
        default y if PACKAGE_$(PKG_NAME)

    config PACKAGE_freeradius3-mod-expiration
        default y if PACKAGE_$(PKG_NAME)

    config PACKAGE_freeradius3-mod-expr
        default y if PACKAGE_$(PKG_NAME)

    config PACKAGE_freeradius3-mod-files
        default y if PACKAGE_$(PKG_NAME)

    config PACKAGE_freeradius3-mod-logintime
        default y if PACKAGE_$(PKG_NAME)

    config PACKAGE_freeradius3-mod-mschap
        default y if PACKAGE_$(PKG_NAME)

    config PACKAGE_freeradius3-mod-pap
        default y if PACKAGE_$(PKG_NAME)

    config PACKAGE_freeradius3-mod-preprocess
        default y if PACKAGE_$(PKG_NAME)

    config PACKAGE_freeradius3-mod-radutmp
        default y if PACKAGE_$(PKG_NAME)

    config PACKAGE_freeradius3-mod-realm
        default y if PACKAGE_$(PKG_NAME)

    config PACKAGE_freeradius3-mod-sql
        default y if PACKAGE_$(PKG_NAME)

    config PACKAGE_freeradius3-mod-sql-mysql
        default y if PACKAGE_$(PKG_NAME)

    config PACKAGE_freeradius3-mod-sqlcounter
        default y if PACKAGE_$(PKG_NAME)

    config PACKAGE_freeradius3-mod-unix
        default y if PACKAGE_$(PKG_NAME)

    config PACKAGE_freeradius3-utils
        default y if PACKAGE_$(PKG_NAME)

    config PACKAGE_libfreetype
        default y if PACKAGE_$(PKG_NAME)

    config PACKAGE_wget-ssl
        default y if PACKAGE_$(PKG_NAME)

    config PACKAGE_curl
        default y if PACKAGE_$(PKG_NAME)

    config PACKAGE_unzip
        default y if PACKAGE_$(PKG_NAME)

    config PACKAGE_tar
        default y if PACKAGE_$(PKG_NAME)

    config PACKAGE_zoneinfo-asia
        default y if PACKAGE_$(PKG_NAME)

    config PACKAGE_coova-chilli
        default y if PACKAGE_$(PKG_NAME)
endef

define Package/$(PKG_NAME)
    CATEGORY:=LuCI
    SUBMENU:=3. Applications
    TITLE:=LuCI support for Radius Chilli
    PKGARCH:=all
    DEPENDS:=$(LUCI_DEPENDS) $(EXTRA_DEPENDS)
    MAINTAINER:=rtaserver
endef

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
