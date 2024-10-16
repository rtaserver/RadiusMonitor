#!/bin/sh

clean_me() {
rm -rf /etc/uci-defaults/99_setup_radmon
exit 1
}

# ===========================================================================================================
# SETUP PACKAGES ON GITHUB
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

# ===========================================================================================================

chmod +x /usr/bin/acct_log.sh
chmod +x /usr/bin/check_kuota.sh
chmod +x /usr/bin/client_check.sh

# ===========================================================================================================
# SETUP PHP configuration

if grep -qE "memory_limit = [0-9]+M" /etc/php.ini; then
    sed -i -E "s|memory_limit = [0-9]+M|memory_limit = 100M|g" /etc/php.ini
fi

if grep -q "display_errors = On" /etc/php.ini; then
    sed -i -E "s|display_errors = On|display_errors = Off|g" /etc/php.ini
fi

uci get uhttpd.main.index_page | grep -q 'index.php' || uci set uhttpd.main.index_page='index.php'
uci get uhttpd.main.interpreter | grep -q '.php=/usr/bin/php-cgi' || uci set uhttpd.main.interpreter='.php=/usr/bin/php-cgi'

uci commit uhttpd
/etc/init.d/uhttpd restart

# ===========================================================================================================
# SETUP MYSQLD

if grep -q "option enabled '0'" /etc/config/mysqld; then
    sed -i -E "s|option enabled '0'|option enabled '1'|g" /etc/config/mysqld
    sed -i -E "s|# datadir		= /srv/mysql|datadir	= /usr/share/mysql|g" /etc/mysql/conf.d/50-server.cnf
    sed -i -E "s|127.0.0.1|0.0.0.0|g" /etc/mysql/conf.d/50-server.cnf

    # Restart and reload mysqld
    /etc/init.d/mysqld restart
    /etc/init.d/mysqld reload

    # MySQL root password setup and permissions
    mysql -e "SET PASSWORD FOR 'root'@'localhost' = PASSWORD('radius');"
    mysql -e "ALTER USER 'root'@'localhost' IDENTIFIED BY 'radius';"

    # Cleanup default MySQL setup
    mysql -u root -p"radius" <<EOF
DELETE FROM mysql.user WHERE User='';
DROP DATABASE IF EXISTS test;
DELETE FROM mysql.db WHERE Db='test' OR Db='test_%';
FLUSH PRIVILEGES;
EOF

    # Create radius database and set permissions
    mysql -u root -p"radius" -e "CREATE DATABASE radius CHARACTER SET utf8"
    mysql -u root -p"radius" -e "GRANT ALL ON radius.* TO 'radius'@'localhost' IDENTIFIED BY 'radius' WITH GRANT OPTION"

    # Drop all tables in radius database if they exist
    mysql -u root -p"radius" radius -e "SET FOREIGN_KEY_CHECKS = 0; \
        $(mysql -u root -p"radius" radius -e 'SHOW TABLES' | awk '{print "DROP TABLE IF EXISTS `" $1 "`;"}' | grep -v '^Tables' | tr '\n' ' ') \
        SET FOREIGN_KEY_CHECKS = 1;"
fi

# Import SQL files into radius database
if [ ! -e /etc/hotspotsetup ]; then
    mysql -u root -p"radius" radius < /radius_monitor.sql
    rm -rf /radius_monitor.sql
    touch /etc/hotspotsetup
else
    rm -rf /radius_monitor.sql
fi
mysql -u root -p"radius" radius < /www/RadiusMonitor/radmon.sql
mysql -u root -p"radius" radius < /www/raddash/raddash.sql

# ===========================================================================================================
# SETUP FREERADIUS

# Stop Freeradius
/etc/init.d/radiusd stop

cd /etc/freeradius3/mods-enabled

[ ! -L always ] && ln -s ../mods-available/always
[ ! -L attr_filter ] && ln -s ../mods-available/attr_filter
[ ! -L chap ] && ln -s ../mods-available/chap
[ ! -L detail ] && ln -s ../mods-available/detail
[ ! -L digest ] && ln -s ../mods-available/digest
[ ! -L eap ] && ln -s ../mods-available/eap
[ ! -L exec ] && ln -s ../mods-available/exec
[ ! -L expiration ] && ln -s ../mods-available/expiration
[ ! -L expr ] && ln -s ../mods-available/expr
[ ! -L files ] && ln -s ../mods-available/files
[ ! -L logintime ] && ln -s ../mods-available/logintime
[ ! -L mschap ] && ln -s ../mods-available/mschap
[ ! -L pap ] && ln -s ../mods-available/pap
[ ! -L preprocess ] && ln -s ../mods-available/preprocess
[ ! -L radutmp ] && ln -s ../mods-available/radutmp
[ ! -L realm ] && ln -s ../mods-available/realm
[ ! -L sql ] && ln -s ../mods-available/sql
[ ! -L sradutmp ] && ln -s ../mods-available/sradutmp
[ ! -L unix ] && ln -s ../mods-available/unix

cd /etc/freeradius3/sites-enabled

[ ! -L default ] && ln -s ../sites-available/default
[ ! -L inner-tunnel ] && ln -s ../sites-available/inner-tunnel

# Cek Lokal Startup
grep -qxF '/etc/init.d/radiusd restart' /etc/rc.local || sed -i '/exit 0/i /etc/init.d/radiusd restart' /etc/rc.local
grep -qxF '/etc/init.d/chilli restart' /etc/rc.local || sed -i '/exit 0/i /etc/init.d/chilli restart' /etc/rc.local


# ===========================================================================================================
# Hotspot Pages
[ ! -L /www/hotspotlogin ] && ln -s /usr/share/hotspotlogin /www/hotspotlogin

#Restore
if [ -d "/tmp/hotspotlogin" ]; then
    rm -rf /www/hotspotlogin
    rm -rf /usr/share/hotspotlogin
    mv /tmp/hotspotlogin /usr/share/hotspotlogin
    ln -s /usr/share/hotspotlogin /www/hotspotlogin
fi

# ===========================================================================================================
# SETUP NETWORK FIREWALL
uci set network.chilli=interface
uci set network.chilli.proto='none'
uci set network.chilli.device='tun0'

uci set network.hotspot=interface
uci set network.hotspot.proto='static'
uci set network.hotspot.ipaddr='10.10.30.1'
uci set network.hotspot.netmask='255.255.255.0'

uci commit network

if ! uci show firewall | grep -q "firewall\.tun="; then
	uci add firewall zone
	uci set firewall.@zone[-1].name='tun'
	uci set firewall.@zone[-1].input='ACCEPT'
	uci set firewall.@zone[-1].output='ACCEPT'
	uci set firewall.@zone[-1].forward='REJECT'
	uci add_list firewall.@zone[-1].network='chilli'
	uci add firewall forwarding
	uci set firewall.@forwarding[-1].src='tun'
	uci set firewall.@forwarding[-1].dest='wan'
    uci commit firewall
fi

if ! uci show firewall | grep -q "firewall.@zone[0].network=hotspot"; then
	uci add_list firewall.@zone[0].network='hotspot'
    uci commit firewall
fi
# ===========================================================================================================

rm -rf /etc/uci-defaults/99_setup_radmon
exit 0