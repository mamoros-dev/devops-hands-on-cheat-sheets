#!/usr/bin/env bash
#
# Name / Nombre: clean-logs.sh
# Description (EN): Safely compresses or removes log files older than X days in a target directory.
# Descripción (ES): Comprime o elimina de forma segura archivos de log con antigüedad mayor a X días.

set -euo pipefail

LOG_DIR="${1:-/var/log/app}"
DAYS_OLD="${2:-7}"

# Guard check / Verificación de seguridad
if [ ! -d "$LOG_DIR" ]; then
    echo "[!] Error: Directory $LOG_DIR does not exist. / El directorio no existe."
    exit 1
fi

echo "[i] Scanning $LOG_DIR for logs older than $DAYS_OLD days..."
echo "[i] Escaneando $LOG_DIR buscando logs de más de $DAYS_OLD días..."

# Parameters / Parámetros:
# find -type f: Selects files only / Selecciona solo archivos.
# -name "*.log": Matches .log extensions / Filtra por extensión .log.
# -mtime +X: Modified more than X days ago / Modificados hace más de X días.
# -exec gzip: Compresses identified log files / Comprime los archivos encontrados.

find "$LOG_DIR" -type f -name "*.log" -mtime +"$DAYS_OLD" -exec gzip -v {} \;

echo "[✓] Cleanup completed successfully. / Limpieza completada con éxito."