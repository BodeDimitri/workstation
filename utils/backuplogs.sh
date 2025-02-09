#!/bin/bash

# Define backup directory
BACKUP_DIR="/home/yakov/backup"
BACKUP_LOG="$BACKUP_DIR/logbackup.txt"

# Create the backup directory if it doesn't exist
mkdir -p "$BACKUP_DIR"

# Start logging
echo "Starting backup on $(date)" > "$BACKUP_LOG"

# Copy directories to the backup location
cp -R /etc "$BACKUP_DIR" && echo "Successfully backed up /etc" >> "$BACKUP_LOG" || echo "Error backing up /etc" >> "$BACKUP_LOG"
cp -R /opt "$BACKUP_DIR" && echo "Successfully backed up /opt" >> "$BACKUP_LOG" || echo "Error backing up /opt" >> "$BACKUP_LOG"
cp -R /srv "$BACKUP_DIR" && echo "Successfully backed up /srv" >> "$BACKUP_LOG" || echo "Error backing up /srv" >> "$BACKUP_LOG"
cp -R /usr/local/sbin "$BACKUP_DIR" && echo "Successfully backed up /usr/local/sbin" >> "$BACKUP_LOG" || echo "Error backing up /usr/local/sbin" >> "$BACKUP_LOG"
cp -R /usr/local/bin "$BACKUP_DIR" && echo "Successfully backed up /usr/local/bin" >> "$BACKUP_LOG" || echo "Error backing up /usr/local/bin" >> "$BACKUP_LOG"
cp -R /var "$BACKUP_DIR" && echo "Successfully backed up /var" >> "$BACKUP_LOG" || echo "Error backing up /var" >> "$BACKUP_LOG"
cp -R /root "$BACKUP_DIR" && echo "Successfully backed up /root" >> "$BACKUP_LOG" || echo "Error backing up /root" >> "$BACKUP_LOG"
cp -R /home "$BACKUP_DIR" && echo "Successfully backed up /home" >> "$BACKUP_LOG" || echo "Error backing up /home" >> "$BACKUP_LOG"

# Compress the backup directory into a tar.gz file
TAR_FILE="/home/yakov/backup_$(date +%Y-%m-%d_%H-%M-%S).tar.gz"
tar -czvf "$TAR_FILE" -C "$BACKUP_DIR" .

# Confirmation message
echo "Backup completed. Files are stored in $TAR_FILE" >> "$BACKUP_LOG"
echo "Backup completed on $(date)" >> "$BACKUP_LOG"

