#!/bin/bash

echo "Downloading marzban script"
wget -O /marz/marz.zip https://github.com/Gozargah/Marzban/archive/refs/heads/master.zip  > /dev/null 2>&1
if [ $? -ne 0 ]; then
    echo "Error: Failed to download Marzban" && exit 1
fi
echo "Download file completed"

unzip /marz/marz.zip -d /marz
mv /marz/Marzban-master/* /marz
rm -rf /marz/Marzban-master /marz/marz.zip