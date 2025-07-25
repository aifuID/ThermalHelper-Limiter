#!/system/bin/sh

MODDIR=${0%/*}
BB=$MODDIR/tools/busybox
LOG_FILE="/data/local/tmp/thermal_helper.log"

# --- CONFIG ---
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

CURRENT_STATE="init"

echo "--- ThermalHelper-Limiter Log (Ultra Loop 41°C → 38°C) ---" > $LOG_FILE
echo "Daemon started at $(date)" >> $LOG_FILE
echo "Monitoring zones: $CORE_ZONES" >> $LOG_FILE
echo "--------------------------------------------------------" >> $LOG_FILE

while true; do
  MAX_TEMP=0
  for ZONE in $CORE_ZONES; do
    ZONE_TEMP=$($BB cat /sys/class/thermal/thermal_zone${ZONE}/temp 2>/dev/null)
    [ "$ZONE_TEMP" -gt "$MAX_TEMP" ] && MAX_TEMP=$ZONE_TEMP
  done

  MAX_C=$((MAX_TEMP / 1000))

  # 🚀 Switch to COMBAT MODE if ≥ 41°C
  if [ "$MAX_C" -ge 41 ]; then
    if [ "$CURRENT_STATE" != "THROTTLE" ]; then
      echo "$LITTLE_THROTTLE" > $LITTLE_PATH
      echo "$BIG_THROTTLE" > $BIG_PATH
      echo "$PRIME_THROTTLE" > $PRIME_PATH
      echo "$(date): 🌡️ ${MAX_C}°C → COMBAT MODE (Limit ON)" >> $LOG_FILE
      CURRENT_STATE="THROTTLE"
    fi

  # ❄️ Switch to CALM MODE if ≤ 38°C
  elif [ "$MAX_C" -le 38 ]; then
    if [ "$CURRENT_STATE" != "PERF" ]; then
      echo "$LITTLE_PERF" > $LITTLE_PATH
      echo "$BIG_PERF" > $BIG_PATH
      echo "$PRIME_PERF" > $PRIME_PATH
      echo "$(date): 🌡️ ${MAX_C}°C → CALM MODE (Limit OFF)" >> $LOG_FILE
      CURRENT_STATE="PERF"
    fi
  fi

  # Delay super ringan 0.25s (ultra responsif)
  $BB usleep 250000
done
