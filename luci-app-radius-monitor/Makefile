include $(TOPDIR)/rules.mk

PKG_NAME:=luci-app-radius-monitor
PKG_VERSION:=2.3
PKG_MAINTAINER:=Maizil <maizilpc7@gmail.com>

PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)

include $(INCLUDE_DIR)/package.mk

define Package/$(PKG_NAME)
    CATEGORY:=LuCI
    SUBMENU:=3. Applications
    TITLE:=LuCI support for Radius Chilli
    PKGARCH:=all
    DEPENDS:=+luci +luci-base +git +git-http +unzip
    MAINTAINER:=rtaserver
endef

define Package/$(PKG_NAME)/description
    A LuCI support for Radius Chilli
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

# Pre-install steps
define Package/$(PKG_NAME)/preinst
#!/bin/sh
    cp -rf "/usr/share/hotspotlogin" "/tmp/hotspotlogin" >/dev/null 2>&1
    exit 0
endef

# Post-install steps
define Package/$(PKG_NAME)/postinst
#!/bin/sh
    PHP8="libc php8 php8-fastcgi php8-fpm coreutils-stat zoneinfo-asia php8-cgi \
    php8-cli php8-mod-bcmath php8-mod-calendar php8-mod-ctype php8-mod-curl php8-mod-dom php8-mod-exif \
    php8-mod-fileinfo php8-mod-filter php8-mod-gd php8-mod-iconv php8-mod-intl php8-mod-mbstring php8-mod-mysqli \
    php8-mod-mysqlnd php8-mod-opcache php8-mod-pdo php8-mod-pdo-mysql php8-mod-phar php8-mod-session \
    php8-mod-xml php8-mod-xmlreader php8-mod-xmlwriter php8-mod-zip libopenssl-legacy"
    
    MARIADB="mariadb-server mariadb-server-extra mariadb-client mariadb-client-extra libmariadb nano"
    
    FREERADIUS="freeradius3 freeradius3-common freeradius3-default freeradius3-mod-always freeradius3-mod-attr-filter \
    freeradius3-mod-chap freeradius3-mod-detail freeradius3-mod-digest freeradius3-mod-eap \
    freeradius3-mod-eap-gtc freeradius3-mod-eap-md5 freeradius3-mod-eap-mschapv2 freeradius3-mod-eap-peap \
    freeradius3-mod-eap-pwd freeradius3-mod-eap-tls freeradius3-mod-eap-ttls freeradius3-mod-exec \
    freeradius3-mod-expiration freeradius3-mod-expr freeradius3-mod-files freeradius3-mod-logintime \
    freeradius3-mod-mschap freeradius3-mod-pap freeradius3-mod-preprocess freeradius3-mod-radutmp \
    freeradius3-mod-realm freeradius3-mod-sql freeradius3-mod-sql-mysql freeradius3-mod-sqlcounter \
    freeradius3-mod-unix freeradius3-utils libfreetype wget-ssl curl unzip tar zoneinfo-asia coova-chilli"

    # Function untuk mengecek apakah paket sudah terpasang
    check_installed() {
        for package in $1; do
            if ! opkg list-installed | grep -qw "$package"; then
                echo "Paket $package belum terpasang. Menambah ke daftar instalasi."
                INSTALL_LIST="$INSTALL_LIST $package"
            else
                echo "Paket $package sudah terpasang."
            fi
        done
    }

    # Daftar paket yang belum terpasang
    INSTALL_LIST=""

    # Cek setiap kelompok paket
    echo "Memeriksa paket PHP..."
    check_installed "$PHP8"

    echo "Memeriksa paket MariaDB..."
    check_installed "$MARIADB"

    echo "Memeriksa paket FreeRADIUS..."
    check_installed "$FREERADIUS"

    # Jika ada paket yang belum terpasang, install
    if [ -n "$INSTALL_LIST" ]; then
        echo "Menginstal paket-paket berikut: $INSTALL_LIST"
        opkg install $INSTALL_LIST
    else
        echo "Semua paket sudah terpasang."
    fi

    # Download Packages
    BASE_URL="https://github.com/rtaserver/RadiusMonitor/archive/refs/heads/radius.zip"
    ZIP_FILE="/tmp/radius.zip"
    DEST_DIR="/"
    
    echo "Mengunduh file ZIP dari $BASE_URL..."
    wget -O "$ZIP_FILE" "$BASE_URL"

    if [ $? -eq 0 ]; then
        echo "Ekstraksi file ZIP ke $DEST_DIR dengan force overwrite..."
        unzip -o "$ZIP_FILE" -d "$DEST_DIR"
        if [ $? -eq 0 ]; then
            echo "Ekstraksi selesai."
        else
            echo "Ekstraksi gagal."
			exit 1
        fi
    else
        echo "Gagal mengunduh file ZIP."
		exit 1
    fi

    if [ ! -d /www/raddash ]; then
        if git clone https://github.com/umblox/raddash /www/raddash > /dev/null 2>&1; then
            echo "Clone raddash berhasil."
        else
            echo "Clone raddash gagal."
            exit 1
        fi
    else
        cd /www/raddash || { echo "Gagal masuk ke direktori /www/raddash"; exit 1; }
        if git pull > /dev/null 2>&1; then
            echo "Update raddash berhasil."
        else
            echo "Update raddash gagal."
            exit 1
        fi
    fi

    if [ ! -d /www/RadiusMonitor ]; then
        if git clone https://github.com/Maizil41/RadiusMonitor /www/RadiusMonitor > /dev/null 2>&1; then
            echo "Clone RadiusMonitor berhasil."
        else
            echo "Clone RadiusMonitor gagal."
            exit 1
        fi
    else
        cd /www/RadiusMonitor || { echo "Gagal masuk ke direktori /www/RadiusMonitor"; exit 1; }
        if git pull > /dev/null 2>&1; then
            echo "Update RadiusMonitor berhasil."
        else
            echo "Update RadiusMonitor gagal."
            exit 1
        fi
    fi
    exit 0
endef

# Pre-removal steps
define Package/$(PKG_NAME)/prerm
#!/bin/sh
    /etc/init.d/radiusd stop
    /etc/init.d/chilli stop
    cp -rf "/usr/share/hotspotlogin" "/tmp/hotspotlogin" >/dev/null 2>&1
    exit 0
endef

# Post-removal steps
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