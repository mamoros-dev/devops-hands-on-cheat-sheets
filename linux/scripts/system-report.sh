#!/usr/bin/env bash
#
# Name / Nombre: system-report.sh
# Description (EN): Generates a high-level system diagnostic report (CPU, RAM, Storage, Uptime).
# Descripción (ES): Genera un informe resumido de diagnóstico del sistema (CPU, RAM, Disco, Uptime).

set -euo pipefail

echo "========================================================"
echo "          SYSTEM HEALTH REPORT / INFORME DEL SISTEMA    "
echo "========================================================"
echo "Date / Fecha: $(date '+%Y-%m-%d %H:%M:%S')"
echo "Hostname / Host: $(hostname)"
echo "Kernel / Núcleo: $(uname -r)"
echo "Uptime / Tiempo activo: $(uptime -p)"
echo "--------------------------------------------------------"

echo -e "\n--- CPU & Load Average / Carga de CPU ---"
uptime | awk -F'load average:' '{ print "Load Average:" $2 }'

echo -e "\n--- Memory Summary / Resumen de Memoria ---"
free -h | awk '
    /^Mem:/ { printf "RAM Used/Usada: %s / Total: %s (Free/Libre: %s)\n", $3, $2, $4 }
    /^Swap:/ { printf "Swap Used/Usada: %s / Total: %s\n", $3, $2 }
'

echo -e "\n--- Disk Storage / Almacenamiento ---"
df -h --total | grep -E 'Filesystem|total'

echo -e "\n========================================================"