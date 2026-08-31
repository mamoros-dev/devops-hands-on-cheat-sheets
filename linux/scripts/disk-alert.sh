#!/usr/bin/env bash
#
# Name / Nombre: disk-alert.sh
# Description (EN): Checks disk space utilization and prints an alert if thresholds are exceeded.
# Descripción (ES): Comprueba el uso del disco y emite una alerta si supera los umbrales definidos.

set -euo pipefail

# Threshold percentage / Umbral de alerta (%)
THRESHOLD="${1:-80}"

echo "[i] Checking disk usage (Threshold: ${THRESHOLD}%)..."
echo "[i] Comprobando uso de disco (Umbral: ${THRESHOLD}%)..."
echo "--------------------------------------------------------"

# Parameters / Parámetros:
# df -H: Displays disk usage in human-readable format (decimal).
# awk: Parses mount points and usage percentages.

df -H | awk -v thresh="$THRESHOLD" '
    NR > 1 {
        sub(/%/, "", $5);
        if ($5 >= thresh) {
            print "[ALERT/ALERTA] Partition " $6 " is at " $5 "% capacity! / ¡La partición " $6 " está al " $5 "% de capacidad!"
        } else if ($5 > 0) {
            print "[OK] Partition " $6 " usage is at " $5 "% / El uso de " $6 " es del " $5 "%"
        }
    }
'