#!/system/bin/sh
# ThermalHelper-Limiter v1.0-R2 — customize.sh
# by aifuID

MODPATH=${0%/*}

# ───────────────────────────────────────────────
# 🔍 SoC / Chipset Check Only (Snapdragon 865 required)
# ───────────────────────────────────────────────
DEVICE_PROP=$(getprop ro.product.device)
BUILD_PROP=$(getprop ro.build.product)
CPUINFO=$(grep -Ei 'hardware|soc' /proc/cpuinfo)

ui_print ""
ui_print "📱 Detected device name: $DEVICE_PROP / $BUILD_PROP"

if echo "$CPUINFO" | grep -iq "sm8250"; then
  ui_print "✅ Snapdragon 865 (SM8250) detected!"
else
  ui_print "❌ Unsupported SoC! This module is only for Snapdragon 865 (SM8250)"
  ui_print "🔍 Detected CPU Info:"
  ui_print "$CPUINFO"
  abort
fi

ui_print "📝 Note: Device spoofing is allowed, but Snapdragon 865 is mandatory!"

# ───────────────────────────────────────────────
# 📦 ROOT ENVIRONMENT CHECK
# ───────────────────────────────────────────────
MAGISK_VER=$(getprop magisk.version)
if [ -n "$MAGISK_VER" ]; then
  ui_print "✨ Magisk Detected: $MAGISK_VER"
  MAGISK_VER_NUM=$(echo "$MAGISK_VER" | sed 's/[^0-9.]//g')
  if [ "$(echo "$MAGISK_VER_NUM < 27.0" | bc)" -eq 1 ]; then
    ui_print "❌ Magisk v27+ required!"
    abort
  fi
fi

if [ -f /data/adb/ksud ]; then
  if command -v kinfo >/dev/null 2>&1; then
    KSU_VER=$(kinfo | grep -i version | awk '{print $2}')
    ui_print "🔐 KernelSU Detected: $KSU_VER"
    if [ "$(echo "$KSU_VER < 1.0.1" | bc)" -eq 1 ]; then
      ui_print "❌ KernelSU v1.0.1+ required!"
      abort
    fi
  fi
fi

SUKISU_VER=$(getprop ksu.sukisu.version)
if [ -n "$SUKISU_VER" ]; then
  ui_print "🐉 SukiSU Ultra Detected: $SUKISU_VER"
  if [ "$(echo "$SUKISU_VER < 3.1.1" | bc)" -eq 1 ]; then
    ui_print "❌ SukiSU v3.1.1+ required!"
    abort
  fi
fi

RKSU_VER=$(getprop rksu.version)
if [ -n "$RKSU_VER" ]; then
  ui_print "🔧 RKSU Detected: $RKSU_VER"
  if [ "$(echo "$RKSU_VER < 1.0.0" | bc)" -eq 1 ]; then
    ui_print "❌ RKSU v1.0.0+ required!"
    abort
  fi
fi

if [ -f /.apatch_version ]; then
  APATCH_VER=$(cat /.apatch_version | tr -dc '0-9')
  ui_print "🛡️ Apatch Detected: v$APATCH_VER"
  if [ "$APATCH_VER" -lt 10569 ]; then
    ui_print "❌ Apatch v10569+ required!"
    abort
  fi
fi

if [ -z "$MAGISK_VER" ] && [ ! -f /data/adb/ksud ] && [ -z "$SUKISU_VER" ] && [ -z "$RKSU_VER" ] && [ ! -f /.apatch_version ]; then
  ui_print "❌ No supported root environment detected!"
  abort
fi

# ───────────────────────────────────────────────
# 🧠 KERNEL DETECTION
# ───────────────────────────────────────────────
KERNEL_VERSION=$(uname -r)
KERNEL_FULL=$(uname -a)
KERNEL_MAJOR=$(echo "$KERNEL_VERSION" | cut -d. -f1)
KERNEL_MINOR=$(echo "$KERNEL_VERSION" | cut -d. -f2)

ui_print ""
ui_print "🧠 Kernel Detected:"
ui_print "   ➤ Version : $KERNEL_VERSION"
ui_print "   ➤ Full    : $KERNEL_FULL"

if echo "$KERNEL_FULL" | grep -iq "gki"; then
  if [ "$KERNEL_MAJOR" -eq 4 ] && [ "$KERNEL_MINOR" -eq 19 ]; then
    ui_print "📦 GKI1 Detected: Kernel v$KERNEL_VERSION"
  elif [ "$KERNEL_MAJOR" -eq 5 ]; then
    ui_print "📦 GKI2 Detected: Kernel v$KERNEL_VERSION"
  elif [ "$KERNEL_MAJOR" -ge 6 ]; then
    ui_print "⚠️ GKI (Future) Kernel v$KERNEL_VERSION — Experimental support!"
  else
    ui_print "📦 GKI Kernel Detected: v$KERNEL_VERSION"
  fi
fi

# ───────────────────────────────────────────────
# ✨ ANIME INSTALLER STYLE + WARNING
# ───────────────────────────────────────────────
ui_print ""
ui_print "╭────────────────────────────────────────────╮"
ui_print "│ ✨ ThermalHelper-Limiter v1.0-R ✨          │"
ui_print "│ 🧊『Balance Your Power, Control The Heat』🔥 │"
ui_print "╰────────────────────────────────────────────╯"
sleep 1

ui_print ""
ui_print "⚠️ DO NOT combine with other thermal/performance mods!"
sleep 1
ui_print "🌸 [KawaiiWaifu.exe] Initializing~ Please wait, Master~ (≧◡≦)/"
sleep 1
ui_print "🧙‍♂️ [DarkDaemon.vortex] Channeling thermal energies..."
sleep 1

ui_print ""
ui_print "❌ Remove any:"
ui_print "   - CPU/GPU booster mods"
ui_print "   - Thermal spoof or tweaks"
sleep 1
ui_print "🐲 [RyuMode] Calibrating throttle zones..."
sleep 1
ui_print "👩‍💻 [OtakuShell.sys] Injecting busybox binaries..."
sleep 1
ui_print "😎 [SenpaiBoost] Setting CPU frequencies like a boss."
sleep 1

ui_print ""
ui_print "🛑 FINAL WARNING:"
ui_print "❌ Conflicts = unstable device + sad waifu 😭"
sleep 2

# ───────────────────────────────────────────────
# 🔐 Set permission otomatis
# ───────────────────────────────────────────────
ui_print ""
ui_print "🔐 Setting executable permissions..."
chmod 755 "$MODPATH"/service.sh
chmod 755 "$MODPATH"/post-fs-data.sh
chmod 755 "$MODPATH"/tools/busybox* 2>/dev/null

# ───────────────────────────────────────────────
# ✅ Install sukses!
# ───────────────────────────────────────────────
ui_print ""
ui_print "✅ ThermalHelper-Limiter has been installed successfully!"
ui_print "🔥 Ready to guard your heat like a true ninja."
ui_print ""
ui_print "🌌 Deployment complete, Master~ ♥"
ui_print "~ Powered by aifuID. Limit heat, unleash waifu. ✨"
