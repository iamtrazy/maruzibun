#!/bin/bash
/marz/setup_env.sh
alembic upgrade head
nohup python main.py &>/dev/null &
nohup caddy run --config /etc/caddy/Caddyfile --adapter caddyfile