#!/bin/bash

SERVERS=("192.168.1.10" "192.168.1.11")
USER="ubuntu"
KEY_PATH="~/.ssh/id_rsa"
COMMAND=${1:-"uptime"}

for SERVER in "${SERVERS[@]}"; do
  echo "Executando em $SERVER..."
  ssh -i "$KEY_PATH" "$USER@$SERVER" "$COMMAND"
done
