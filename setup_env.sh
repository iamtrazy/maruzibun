#!/bin/bash

ENV_FILE=/marz/.env

if [ -z "$DOMAIN" ]; then
    echo "DOMAIN is not set in .env file"
    exit 1
fi

sed -i "s/\$DOMAIN/$DOMAIN/g" /etc/caddy/Caddyfile

if [ -n "$USERNAME" ] && [ -n "$PASSWORD" ]; then
    echo "SUDO_USERNAME = $USERNAME" >> $ENV_FILE
    echo "SUDO_PASSWORD = $PASSWORD" >> $ENV_FILE
fi
if [ -n "$API_TOKEN" ] && [ -n "$ADMIN_ID" ]; then
    echo "TELEGRAM_API_TOKEN = $API_TOKEN" >> $ENV_FILE
    echo "TELEGRAM_ADMIN_ID = $ADMIN_ID" >> $ENV_FILE
fi