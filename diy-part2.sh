#!/bin/bash
#============================================================
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part2.sh
# Description: OpenWrt DIY script part 2 (After Update feeds)
# Lisence: MIT
# Author: P3TERX
# Blog: https://p3terx.com
#============================================================

sed -i '/DTS_DIR:=$(LINUX_DIR)/a\BUILD_DATE_PREFIX := $(shell date +'%F')' ./include/image.mk
sed -i 's/IMG_PREFIX:=/IMG_PREFIX:=$(BUILD_DATE_PREFIX)-/g' ./include/image.mk
sed -i "s/DISTRIB_DESCRIPTION='OpenWrt '/DISTRIB_DESCRIPTION='OpenWrt by Kanny'/g" ./package/lean/default-settings/files/zzz-default-settings
sed -i "s/hostname='OpenWrt'/hostname='OpenWrt-SE'/g" ./package/base-files/files/bin/config_generate
date=`date +%m.%d.%Y`
sed -i "s/DISTRIB_DESCRIPTION.*/DISTRIB_DESCRIPTION='%D %V %C by Kenny'/g" package/base-files/files/etc/openwrt_release
sed -i "s/# REVISION:=x/REVISION:= $date/g" include/version.mk

# Modify default IP
#sed -i 's/192.168.1.1/192.168.50.5/g' package/base-files/files/bin/config_generate

rm -rf ./package/lean/luci-theme-argon
git clone https://github.com/jerrykuku/luci-theme-argon -b 18.06 ./package/lean/luci-theme-argon

rm -rf ./feeds/packages/net/smartdns
git clone https://github.com/alloneinfo/openwrt-smartdns ./feeds/packages/net/smartdns
#sed -i '/PKG_VERSION:=/{s/.*/PKG_VERSION:=8.2020.24/g};/PKG_SOURCE_VERSION:=/{s/.*/PKG_SOURCE_VERSION:=Release32/g}' ./feeds/packages/net/smartdns/Makefile
sed -i '/PKG_VERSION:=/{s/.*/PKG_VERSION:=8.2020.24/g};/PKG_SOURCE_VERSION:=/{s/.*/PKG_SOURCE_VERSION:=a3d3364a326374c52ec85ac52c92b31a233674f7/g}' ./feeds/packages/net/smartdns/Makefile

# 替换 luci-app-zerotier
rm -rf ./package/lean/luci-app-zerotier
git clone https://github.com/alloneinfo/luci-app-zerotier ./package/lean/luci-app-zerotier

# rm -rf ./feeds/packages/utils/syncthing
# svn co https://github.com/alloneinfo/openwrt_feeds/trunk/syncthing ./feeds/packages/utils/syncthing
sed -i '/PKG_VERSION:=/{s/.*/PKG_VERSION:=1.8.0/g}' ./feeds/packages/utils/syncthing/Makefile
sed -i '/PKG_HASH:=/{s/.*/PKG_HASH:=04d78fbe6015334c284bf46ffcf8feb6b2b690ef810f2f0c5732cdee5cd8142a/g}' ./feeds/packages/utils/syncthing/Makefile
#sed -i '/PKG_HASH:=/{s/.*/PKG_HASH:=skip/g}' ./feeds/packages/utils/syncthing/Makefile

