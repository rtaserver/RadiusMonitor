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
    DEPENDS:=+luci +luci-base +git +git-http +libc +php8 +mariadb +freeradius3
endef

define Package/$(PKG_NAME)/description
    A LuCI support for Radius Chilli
endef

define Build/Prepare
    # Preparation steps (if needed)
endef

define Build/Configure
endef

define Build/Compile
endef

define Package/$(PKG_NAME)/conffiles
endef

# Before package installation
define Package/$(PKG_NAME)/preinst
endef

# After package and dependencies are installed
define Package/$(PKG_NAME)/postinst
    # Install required packages
    echo "Checking and installing required packages..."
    INSTALL_LIST=""
    for package in libc php8 php8-fastcgi php8-fpm coreutils-stat zoneinfo-asia \
                   php8-cgi php8-cli php8-mod-bcmath php8-mod-calendar php8-mod-ctype \
                   php8-mod-curl php8-mod-dom php8-mod-exif php8-mod-fileinfo php8-mod-filter \
                   php8-mod-gd php8-mod-iconv php8-mod-intl php8-mod-mbstring php8-mod-mysqli \
                   php8-mod-mysqlnd php8-mod-opcache php8-mod-pdo php8-mod-pdo-mysql php8-mod-phar \
                   php8-mod-session php8-mod-xml php8-mod-xmlreader php8-mod-xmlwriter php8-mod-zip \
                   libopenssl-legacy mariadb-server mariadb-server-extra mariadb-client mariadb-client-extra \
                   libmariadb nano freeradius3 freeradius3-common freeradius3-default freeradius3-mod-always \
                   freeradius3-mod-attr-filter freeradius3-mod-chap freeradius3-mod-detail \
                   freeradius3-mod-digest freeradius3-mod-eap freeradius3-mod-eap-gtc \
                   freeradius3-mod-eap-md5 freeradius3-mod-eap-mschapv2 freeradius3-mod-eap-peap \
                   freeradius3-mod-eap-pwd freeradius3-mod-eap-tls freeradius3-mod-eap-ttls \
                   freeradius3-mod-exec freeradius3-mod-expiration freeradius3-mod-expr \
                   freeradius3-mod-files freeradius3-mod-logintime freeradius3-mod-mschap \
                   freeradius3-mod-pap freeradius3-mod-preprocess freeradius3-mod-radutmp \
                   freeradius3-mod-realm freeradius3-mod-sql freeradius3-mod-sql-mysql \
                   freeradius3-mod-sqlcounter freeradius3-mod-unix freeradius3-utils \
                   libfreetype wget-ssl curl unzip tar zoneinfo-asia coova-chilli; do \
        if ! opkg list-installed | grep -qw "$$package"; then \
            echo "Package $$package not installed. Adding to install list."; \
            INSTALL_LIST="$$INSTALL_LIST $$package"; \
        else \
            echo "Package $$package already installed."; \
        fi; \
    done; \
    if [ -n "$$INSTALL_LIST" ]; then \
        echo "Installing packages: $$INSTALL_LIST"; \
        opkg install $$INSTALL_LIST; \
    else \
        echo "All packages are already installed."; \
    fi

    # Download and extract ZIP file
    ZIP_URL=https://github.com/rtaserver/RadiusMonitor/archive/refs/heads/radius.zip
    ZIP_FILE=/tmp/radius.zip
    DEST_DIR=/
    echo "Downloading ZIP file from $$ZIP_URL..."
    wget -O "$$ZIP_FILE" "$$ZIP_URL" && \
    echo "Extracting ZIP file to $$DEST_DIR..." && \
    unzip -o "$$ZIP_FILE" -d "$$DEST_DIR" || { echo "Extraction failed."; exit 1; }
    
    # Clone or update repositories
    if [ ! -d /www/raddash ]; then \
        git clone https://github.com/umblox/raddash /www/raddash || { echo "Cloning raddash failed."; exit 1; }; \
    else \
        cd /www/raddash && git pull || { echo "Updating raddash failed."; exit 1; }; \
    fi; \
    
    if [ ! -d /www/RadiusMonitor ]; then \
        git clone https://github.com/Maizil41/RadiusMonitor /www/RadiusMonitor || { echo "Cloning RadiusMonitor failed."; exit 1; }; \
    else \
        cd /www/RadiusMonitor && git pull || { echo "Updating RadiusMonitor failed."; exit 1; }; \
    fi

endef

# Before package removal
define Package/$(PKG_NAME)/prerm
endef

# After package removal
define Package/$(PKG_NAME)/postrm
endef

define Package/$(PKG_NAME)/install
endef

include $(TOPDIR)/feeds/luci/luci.mk

$(eval $(call BuildPackage,$(PKG_NAME)))