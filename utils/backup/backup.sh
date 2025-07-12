#!/bin/bash

# Define backup directory
BACKUP_DIR="/home/yakov/backup"

# Create the backup directory if it doesn't exist
mkdir -p "$BACKUP_DIR"

# Copy directories to the backup location
cp -R /etc /opt /srv /usr/local/sbin /usr/local/bin /var /root /home "$BACKUP_DIR" >> logbackup.txt

# Confirmation message
echo "Backup completed. Files are stored in $BACKUP_DIR"

