#!/system/bin/sh

MODDIR=${0%/*}
LOG_FILE="/data/adb/thermal_helper.log"

# Coba langsung log ke awal boot (fase post-fs-data)
echo "[post-fs-data] ThermalHelper-Limiter init: $(date)" >> "$LOG_FILE"

# Jalankan thermal daemon di background
sh "$MODDIR/service.sh" &
