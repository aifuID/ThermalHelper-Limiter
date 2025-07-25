#!/system/bin/sh

# ──────────────────────────────────────
# 🌡️ ThermalHelper-Limiter v1.0-R Daemon
# ──────────────────────────────────────

MODDIR=${0%/*}
LOG_FILE="/data/adb/thermal_helper.log"

# Fungsi deteksi busybox
find_busybox() {
  for BBT in "$MODDIR/tools/busybox-feravolt" "$MODDIR/tools/busybox"; do
    if [ -x "$BBT" ]; then
      echo "$BBT"
      return
    fi
  done

  BB_SYSTEM=$(which busybox 2>/dev/null)
  if [ -x "$BB_SYSTEM" ]; then
    echo "$BB_SYSTEM"
    return
  fi

  for PATHCAND in /sbin /system/xbin /system/bin /vendor/bin /apex/*/bin; do
    if [ -x "$PATHCAND/busybox" ]; then
      echo "$PATHCAND/busybox"
      return
    fi
  done

  echo ""
}

BB=$(find_busybox)

if [ -z "$BB" ]; then
  echo "❌ BusyBox not found. Aborting." > "$LOG_FILE"
  exit 1
fi

BB_VER=$($BB --version | head -n1)
echo "--- ThermalHelper-Limiter Log v1.0-R ---" > "$LOG_FILE"
echo "🧰 BusyBox: $BB_VER" >> "$LOG_FILE"
echo "Daemon started at $(date)" >> "$LOG_FILE"

CORE_ZONES="9 10 11 12"
LITTLE_THROTTLE="1420000"
BIG_THROTTLE="2054000"
PRIME_THROTTLE="1862000"
LITTLE_PERF="1804000"
BIG_PERF="2419000"
PRIME_PERF="2841000"

LITTLE_PATH="/sys/devices/system/cpu/cpu0/cpufreq/scaling_max_freq"
BIG_PATH="/sys/devices/system/cpu/cpu4/cpufreq/scaling_max_freq"
PRIME_PATH="/sys/devices/system/cpu/cpu7/cpufreq/scaling_max_freq"

echo "Guarding Thermal Zones: $CORE_ZONES" >> "$LOG_FILE"
CURRENT_STATE="init"

while true; do
  MAX_TEMP=0
  for ZONE in $CORE_ZONES; do
    ZONE_PATH="/sys/class/thermal/thermal_zone${ZONE}/temp"
    if [ -f "$ZONE_PATH" ]; then
      CURRENT_TEMP=$($BB cat "$ZONE_PATH")
      if [ "$CURRENT_TEMP" -gt "$MAX_TEMP" ]; then
        MAX_TEMP=$CURRENT_TEMP
      fi
    fi
  done

  if [ "$MAX_TEMP" -ge 41000 ]; then
    if [ "$CURRENT_STATE" != "THROTTLE" ]; then
      echo "$LITTLE_THROTTLE" > "$LITTLE_PATH"
      echo "$BIG_THROTTLE" > "$BIG_PATH"
      echo "$PRIME_THROTTLE" > "$PRIME_PATH"
      echo "$(date): 🔥 Temp: $MAX_TEMP → COMBAT MODE (Limit ON)" >> "$LOG_FILE"
      CURRENT_STATE="THROTTLE"
    fi
  elif [ "$MAX_TEMP" -le 38000 ]; then
    if [ "$CURRENT_STATE" != "PERF" ]; then
      echo "$LITTLE_PERF" > "$LITTLE_PATH"
      echo "$BIG_PERF" > "$BIG_PATH"
      echo "$PRIME_PERF" > "$PRIME_PATH"
      echo "$(date): ❄️ Temp: $MAX_TEMP → CALM MODE (Limit OFF)" >> "$LOG_FILE"
      CURRENT_STATE="PERF"
    fi
  fi

  $BB sleep 1
done
