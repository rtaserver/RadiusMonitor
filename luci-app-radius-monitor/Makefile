# This is free software, licensed under the Apache License, Version 2.0
#
# Copyright (C) 2024 Maizil <maizilpc7@gmail.com>

include $(TOPDIR)/rules.mk

LUCI_TITLE:=LuCI for Radius Monitor.
LUCI_DEPENDS:=+luci +git +git-http +php8-cli +php8-mod-mysqli +php8-mod-pdo-mysql +php8-mod-gd +php8-mod-xml +php8-mod-filter +php8-mod-curl +iptables-nft +iptables-mod-hashlimit \
+freeradius3-default +freeradius3-mod-sql-mysql +freeradius3-mod-sqlcounter +freeradius3-utils \
+mariadb-client-extra +mariadb-server-extra +coova-chilli
LUCI_DESCRIPTION:=Application for monitoring RADIUS server.
LUCI_MAINTAINER:=Maizil <maizilpc7@gmail.com>

PKG_MAINTAINER:=Maizil <maizilpc7@gmail.com>
PKG_VERSION:=2.3
PKG_RELEASE:=beta
PKG_LICENSE:=Apache-2.0
PKG_ARCH:=all

define Package/$(PKG_NAME)/preinst
#!/bin/sh
    cp -rf "/usr/share/hotspotlogin" "/tmp/hotspotlogin" >/dev/null 2>&1
    exit 0
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

include $(TOPDIR)/feeds/luci/luci.mk

# call BuildPackage - OpenWrt buildroot signature
