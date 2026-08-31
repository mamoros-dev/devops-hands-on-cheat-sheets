#!/bin/bash
# Backup script to sync local backup folder to Amazon S3 bucket
# Script de backup para sincronizar la carpeta de respaldo local con un bucket de Amazon S3

SOURCE_DIR="/var/backups"
BUCKET_NAME="s3://my-devops-backup-bucket-2026/backups"
LOG_FILE="/var/log/s3-backup.log"

echo "[$(date)] Starting S3 Backup Sync..." >> "$LOG_FILE"

if aws s3 sync "$SOURCE_DIR" "$BUCKET_NAME" --delete >> "$LOG_FILE" 2>&1; then
    echo "[$(date)] S3 Backup Completed Successfully." >> "$LOG_FILE"
else
    echo "[$(date)] ERROR: S3 Backup failed!" >> "$LOG_FILE"
    exit 1
fi