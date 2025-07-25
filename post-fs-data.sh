#!/system/bin/sh

MODDIR=${0%/*}
LOG_FILE="/data/adb/thermal_helper.log"

# Log inisialisasi awal
echo "[post-fs-data] ThermalHelper-Limiter init: $(date)" >> "$LOG_FILE"

# Jalankan daemon thermal jika file ada
if [ -f "$MODDIR/service.sh" ]; then
  echo "[post-fs-data] Starting service.sh..." >> "$LOG_FILE"
  sh "$MODDIR/service.sh" &
else
  echo "[post-fs-data] ERROR: service.sh not found in $MODDIR" >> "$LOG_FILE"
fi