#!/bin/bash

mkdir -p /var/log/caddy

if [[ "$(uname)" == 'Linux' ]]; then
    case "$(uname -m)" in
        'amd64' | 'x86_64')
            binArch='amd64';
            checksum='4afdf50ccf3a8f32344dbac46006ca2b5d90c2ef656c53e8617f1c3b81c5f9e44bd3a9e0b62975f73c85451c354d3d9b5292f5247d18a62d95ab19c8b0a5dba7'
        ;;
        'armv8' | 'aarch64')
            binArch='arm64';
            checksum='a857cbe25bcc5402e9c4fa2a6c36338f91b7e23962beedccd32e10b3aa34dda084ae742c79085d6e7581acfe33f7c9cf161224b1e56cdb661ebfb6f7424b8d0a'
        ;;
        *)
            echo "Error: The architecture is not supported by the script"
            exit 1
        ;;
    esac
else
    echo "Error: This operating system is not supported."
    exit 1
fi

echo "Downloading caddy"
wget -O /tmp/caddy.tar.gz "https://github.com/caddyserver/caddy/releases/download/v2.7.5/caddy_2.7.5_linux_${binArch}.tar.gz"  > /dev/null 2>&1
if [ $? -ne 0 ]; then
    echo "Error: Failed to download caddy" && exit 1
fi
echo "Download caddy completed"

echo "$checksum  /tmp/caddy.tar.gz" | sha512sum -c
tar x -z -f /tmp/caddy.tar.gz -C /usr/bin caddy
rm -f /tmp/caddy.tar.gz
chmod +x /usr/bin/caddy
caddy version