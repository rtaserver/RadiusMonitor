#!/bin/sh

# First Build Check And Update

clean_me() {
rm -rf /etc/uci-defaults/80_setup_radmon
rm -rf /etc/uci-defaults/99_setup_radmon
exit 1
}

# Download Packages
BASE_URL="https://github.com/rtaserver/RadiusMonitor/archive/refs/heads/radius.zip"
ZIP_FILE="/tmp/radius.zip"
DEST_DIR="/"

echo "Mengunduh file ZIP dari $BASE_URL..."
wget -O "$ZIP_FILE" "$BASE_URL" > /dev/null 2>&1

if [ $? -eq 0 ]; then
    echo "Ekstraksi file ZIP ke $DEST_DIR dengan force overwrite..."
    unzip -o "$ZIP_FILE" -d "$DEST_DIR" > /dev/null 2>&1
    if [ $? -eq 0 ]; then
        echo "Ekstraksi selesai."
        rm -rf $ZIP_FILE
        cp -a /RadiusMonitor-radius/* /
        rm -rf /RadiusMonitor-radius
        rm -rf /autoscript
        rm -rf /README.md
    else
        echo "Ekstraksi gagal."
        rm -rf /etc/uci-defaults/80_setup_radmon
	clean_me
    fi
else
    echo "Gagal mengunduh file ZIP."
	clean_me
fi

if [ ! -d /www/raddash ]; then
    if git clone https://github.com/umblox/raddash.git /www/raddash > /dev/null 2>&1; then
        echo "Clone raddash berhasil."
    else
        echo "Clone raddash gagal."
        rm -rf /etc/uci-defaults/80_setup_radmon
        clean_me
    fi
else
    cd /www/raddash || { echo "Gagal masuk ke direktori /www/raddash"; exit 1; }
    if git pull > /dev/null 2>&1; then
        echo "Update raddash berhasil."
    else
        echo "Update raddash gagal."
        rm -rf /etc/uci-defaults/80_setup_radmon
        clean_me
    fi
fi

if [ ! -d /www/RadiusMonitor ]; then
    if git clone https://github.com/Maizil41/RadiusMonitor.git /www/RadiusMonitor > /dev/null 2>&1; then
        echo "Clone RadiusMonitor berhasil."
    else
        echo "Clone RadiusMonitor gagal."
        rm -rf /etc/uci-defaults/80_setup_radmon
        clean_me
    fi
else
    cd /www/RadiusMonitor || { echo "Gagal masuk ke direktori /www/RadiusMonitor"; exit 1; }
    if git pull > /dev/null 2>&1; then
        echo "Update RadiusMonitor berhasil."
    else
        echo "Update RadiusMonitor gagal."
        rm -rf /etc/uci-defaults/80_setup_radmon
        clean_me
    fi
fi

rm -rf /etc/uci-defaults/80_setup_radmon
exit 0