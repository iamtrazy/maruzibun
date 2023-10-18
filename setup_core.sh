#!/bin/bash

mkdir -p /var/log/xray /usr/share/xray

if [[ "$(uname)" == 'Linux' ]]; then
    case "$(uname -m)" in
        'amd64' | 'x86_64')
            ARCH='amd64'
        ;;
        'armv8' | 'aarch64')
            ARCH='arm64'
        ;;
        *)
            ARCH=""
        ;;
        
    esac
fi

[ -z "${ARCH}" ] && echo "Error: Not supported OS Architecture" && exit 1
# Download binary file
XRAY_FILE="xray_linux_${ARCH}"

echo "Downloading binary file: ${XRAY_FILE}"
wget -O /usr/local/bin/xray https://dl.lamp.sh/files/${XRAY_FILE} > /dev/null 2>&1
if [ $? -ne 0 ]; then
    echo "Error: Failed to download binary file: ${XRAY_FILE}" && exit 1
fi
echo "Download binary file: ${XRAY_FILE} completed"

echo "Downloading Geodata"
wget -O /usr/share/xray/geosite.dat https://github.com/v2fly/domain-list-community/releases/latest/download/dlc.da > /dev/null 2>&1 && /
wget -O /usr/share/xray/geoip.dat https://github.com/v2fly/geoip/releases/latest/download/geoip.dat > /dev/null 2>&1
if [ $? -ne 0 ]; then
    echo "Error: Failed to download geodata" && exit 1
fi
echo "Download geodata completed"

chmod +x /usr/local/bin/xray