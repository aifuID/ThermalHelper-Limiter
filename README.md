
# 🌡️ ThermalHelper-Limiter v1.0-R — 「True Awakening」

> 🧙‍♀️ “Master~ Aku telah terbangun... Biarkan aku menjaga suhu dan kekuatanmu.”  
> ✨ Intelligent thermal daemon for Snapdragon 865 warriors  
> 🍜 Anime-powered limiter for true balance and ultimate CPU harmony

---

## 💎 Features / Fitur Unggulan

✨ **ENGLISH / INDONESIA**

- 🔥 **Real-Time Thermal Awareness / Pantau Suhu CPU Real-Time**  
  Monitors CPU thermal zones (9–12) like a vigilant guardian angel.  
  Layaknya roh pelindung, modul ini menjaga zona thermal dan bertindak saat suhu melonjak.

- ❄️ **Calm & Combat Mode / Mode Tenang & Tempur Otomatis**  
  Automatically switches CPU frequency based on heat (≥41°C = limit, ≤38°C = restore).  
  Frekuensi CPU akan dibatasi atau dipulihkan secara otomatis tergantung suhu tertinggi.

- 🎯 **LMI-Tuned Zone Targeting / Fokus Zona Thermal LMI**  
  Specially tuned for Snapdragon 865 on LMI devices (zone 9–12).  
  Didesain spesifik untuk Poco F2 Pro (LMI), menjaga zona thermal utama dengan presisi.

- 🧰 **BusyBox Daemon Support / Dukungan BusyBox Universal**  
  Built-in BusyBox fallback ensures full compatibility across root methods.  
  Termasuk BusyBox daemon bawaan agar tetap berfungsi di berbagai sistem root.

- 🧠 **Kernel & GKI Detection / Deteksi Kernel & GKI Otomatis**  
  Identifies GKI1 (4.19), GKI2 (5.10+), even kernel 6.x experimental.  
  Mendeteksi dan menyesuaikan sesuai versi kernel & jenis GKI secara otomatis.

- 🔐 **Full Root Compatibility / Kompatibel dengan Semua Sistem Root**  
  Magisk v27+, KernelSU, KSU Next, Apatch, RKSU, SukiSU — all supported.  
  Bisa digunakan di semua manajer root populer tanpa konflik.

- 🎌 **Anime-style Installer / Installer Gaya Anime**  
  Comes with waifu warnings, emoji effects, and smart conflict detection.  
  Installer-nya bergaya anime, dengan peringatan waifu dan proteksi dari konflik modul.

---

## ⚠️ Waifu Warning / Peringatan Waifu

> ❌ **DO NOT combine this module with:**  
> ❌ **JANGAN gabung modul ini dengan:**

- Thermal mods or CPU/GPU overclockers  
- Tweak modules that boost performance  
- Other thermal limiters or spoofers

🌸 *“Kalau kamu nekat... sistem kamu bisa overheat atau tidak stabil! Aku tidak bisa melindungimu kalau begitu, Master~!”*

---

## 📱 Compatibility / Kompatibilitas

- ✅ SoC must be **Snapdragon 865 (SM8250)**
- ✅ Spoofed device names allowed (e.g. Galaxy S24 Ultra OK)
- ❌ Abort if SoC is not SM8250

> 🧠 “Aku tak peduli kamu siapa. Selama kamu punya SM8250... Aku akan melindungimu.”

---

## 🔐 Root & Kernel Support / Dukungan Root & Kernel

| Root Type      | Minimum Version  |
|----------------|------------------|
| Magisk         | v27.0            |
| KernelSU       | v1.0.1           |
| KSU Next       | v1.0.8           |
| Apatch         | v10569           |
| RKSU           | v1.0.0           |
| SukiSU Ultra   | v3.1.1           |

🧠 GKI Detection:
- GKI1 → Kernel 4.19  
- GKI2 → Kernel 5.10+  
- Kernel 6.x → Experimental

---

## 🔍 How It Works / Cara Kerja

- 🌀 Daemon starts silently after boot (via post-fs-data)  
  Daemon berjalan otomatis setelah boot, diam-diam menjaga suhu.

- 🔎 Monitors zones 9 10 11 12  
  Memantau zona thermal utama Snapdragon 865 secara real-time.

- 🔥 If ≥ 41°C → Enter ⚔️ *Combat Mode*  
  CPU akan dibatasi untuk mencegah overheating.

- ❄️ If ≤ 38°C → Enter ☁️ *Calm Mode*  
  CPU kembali ke frekuensi maksimum saat dingin.

📝 Logs:
/data/adb/thermal_helper.log

---

## 📜 Example Log / Contoh Log

--- ThermalHelper-Limiter Log v1.0-R ---
🧰 BusyBox Daemon
🕓 Boot Detected: Fri Jul 26 02:00:33 UTC 2025
🔒 Guarding Zones: 9 10 11 12
🔥 42100°C → COMBAT MODE ACTIVATED!
❄️ 37700°C → CALM MODE RESTORED!

---

## 🎌 Installer Waifu Mode Activated!

> “Master~ jangan gabung modul ini dengan tweak nakal lain ya~!”  
> 💢 Warning system: Awal + Tengah + Akhir  
> 🌸 Installer ini punya logika deteksi device, SoC, kernel, root type, dan konflik modul

---

## 🔧 Manual Install (Jika Perlu)

```sh
su
cp ThermalHelper-Limiter-v1.0-R.zip /sdcard/
flash via Magisk / KernelSU / Apatch
👑 Credits
📜 Script & Logic: @aifuID

🔧 BusyBox: FeraVolt (Brutal Edition)

🧠 Kernel Detection: Topjohnwu, tiann, and open-source legends

🐉 Powered by: Snapdragon 865, waifu spirit, and anime dreams

❤️ Final Words
🇬🇧 “Balance the heat. Unleash the real power.”
🇮🇩 “Kendalikan panas, lepaskan kekuatanmu yang sebenarnya.”

🌸 “Aku akan melindungi performamu, Master~”