#!/bin/bash

USER="ubuntu"
HOST="192.168.1.10"
KEY="~/.ssh/id_rsa"
SRC="/var/www"
DEST="/home/user/backups/site"

rsync -avz -e "ssh -i $KEY" "$USER@$HOST:$SRC" "$DEST"
