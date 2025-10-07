#!/bin/bash

DOWNLOADS_DIR="$HOME/Downloads"
RETENTION_DAYS=1 #保留天数

#要保证安装了trash-cli

find "$DOWNLOADS_DIR" \
    -maxdepth 1 \
    -mindepth 1 \
    -mtime +$RETENTION_DAYS \
    -exec trash {} +
