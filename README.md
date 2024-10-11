![GitHub Tag](https://img.shields.io/github/v/release/rtaserver/RadiusMonitor?style=for-the-badge&logo=github) ![GitHub Downloads (all assets, all releases)](https://img.shields.io/github/downloads/rtaserver/RadiusMonitor/total?style=for-the-badge&logo=github) ![GitHub Repo stars](https://img.shields.io/github/stars/rtaserver/RadiusMonitor?style=for-the-badge&logo=github) [![Telegram](https://img.shields.io/badge/Contact-Telegram-26A5E4?style=for-the-badge&logo=telegram)](https://t.me/RizkiKotet)

# Radius Monitor By [Maizil41](https://github.com/Maizil41/RadiusMonitor) 

Transparent Proxy with Mihomo on OpenWrt.

> [!WARNING]
>
> - **This Is A Modified Version Of Maizil41 Official Version**
>   
> - Only support firewall4, it means your OpenWrt version needs to be 22.03 or above

## Feature

- Add, Edit & Remove Plans
- Add, Edit & Remove Bandwidth
- Add & Remove Users
- Add & Remove Batch
- Mac Binding Support
- Disconnect Users
- Testing Users using Radtest
- Income Calculation
- Database Restore & Backup
- QRCode Tickets support
- WhatsApp Bot Integration `(coming soon)`
- PPPOE Management `(coming soon)`

## Install & Update

### B. Install From Release

```shell
curl -s -L https://mirror.ghproxy.com/https://github.com/rtaserver/RadiusMonitor/raw/refs/heads/ipk/install.sh | ash
```

## Uninstall & Reset

```shell
curl -s -L https://mirror.ghproxy.com/https://github.com/rtaserver/RadiusMonitor/raw/refs/heads/ipk/uninstall.sh | ash
```

## How To Use

See [Wiki](https://github.com/rtaserver/RadiusMonitor/wiki)

## Dependencies

- MySQL
- Freeradius3
- Coova-Chilli `(For Loginpage)`
- php `8`
- php-mod-mysqli, php-mod-pdo-mysql, php-mod-curl, php-mod-gd
