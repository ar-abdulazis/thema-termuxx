#!/data/data/com.termux/files/usr/bin/bash

# Warna Output
CYAN='\033[1;36m'
MAG='\033[1;35m'
GRN='\033[1;32m'
YEL='\033[1;33m'
RED='\033[1;31m'
NC='\033[0m'

echo -e "${MAG}╔══════════════════════════════════════════════════════╗${NC}"
echo -e "${CYAN}   ⚡ INSTALLER THEMA-TERMUXx (CYBERSMITH EDITION) ⚡   ${NC}"
echo -e "${MAG}╚══════════════════════════════════════════════════════╝${NC}"

# 1. Update & Instal Paket Dasar
echo -e "\n${YEL}[1/6] Memperbarui sistem & menginstal paket dasar...${NC}"
pkg update -y && pkg upgrade -y
pkg install -y git curl zsh nano python tar

# 2. Setup Izin Storage (Lewati jika sudah aktif)
if [ ! -d "$HOME/storage" ]; then
  echo -e "\n${YEL}[2/6] Meminta izin akses penyimpanan HP...${NC}"
  termux-setup-storage
  sleep 2
else
  echo -e "\n${GRN}[2/6] Akses penyimpanan sudah aktif.${NC}"
fi

# 3. Instal Oh My Zsh (Jika belum terpasang)
if [ ! -d "$HOME/.oh-my-zsh" ]; then
  echo -e "\n${YEL}[3/6] Menginstal Oh My Zsh...${NC}"
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
else
  echo -e "\n${GRN}[3/6] Oh My Zsh sudah terpasang.${NC}"
fi

# 4. Instal Plugin Pendukung (Autosuggestions & Syntax Highlighting)
ZSH_CUSTOM=${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}

echo -e "\n${YEL}[4/6] Memasang plugin Zsh...${NC}"
if [ ! -d "$ZSH_CUSTOM/plugins/zsh-autosuggestions" ]; then
  git clone https://github.com/zsh-users/zsh-autosuggestions "$ZSH_CUSTOM/plugins/zsh-autosuggestions"
fi

if [ ! -d "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting" ]; then
  git clone https://github.com/zsh-users/zsh-syntax-highlighting "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting"
fi

# 5. Unduh & Ekstrak Thema-Termuxx
echo -e "\n${YEL}[5/6] Mengunduh & mengekstrak konfigurasi Cybersmith...${NC}"
TEMP_DIR="$HOME/.temp_thema_termuxx"
rm -rf "$TEMP_DIR"
git clone https://github.com/ar-abdulazis/thema-termuxx.git "$TEMP_DIR"

# Backup konfigurasi lama untuk keamanan
[ -f "$HOME/.zshrc" ] && cp "$HOME/.zshrc" "$HOME/.zshrc.bak_$(date +%Y%m%d)"

# Cari file .tar.gz di dalam repo (mendukung nama file arsip apapun di repo)
ARCHIVE_FILE=$(find "$TEMP_DIR" -maxdepth 1 -name "*.tar.gz" | head -n 1)

if [ -n "$ARCHIVE_FILE" ]; then
  tar -xzf "$ARCHIVE_FILE" -C "$HOME"
  echo -e "${GRN}[✔] File konfigurasi berhasil diekstrak dari $(basename "$ARCHIVE_FILE")!${NC}"
else
  echo -e "${RED}[✘] File arsip .tar.gz tidak ditemukan di repositori!${NC}"
  rm -rf "$TEMP_DIR"
  exit 1
fi

# Bersihkan folder sementara
rm -rf "$TEMP_DIR"

# 6. Ubah Default Shell ke Zsh & Terapkan Pengaturan
echo -e "\n${YEL}[6/6] Menerapkan pengaturan akhir...${NC}"
chsh -s zsh
termux-reload-settings

echo -e "\n${GRN}╔══════════════════════════════════════════════════════╗${NC}"
echo -e "${GRN}║  [✔] INSTALASI THEMA-TERMUXx SELESAI!                ║${NC}"
echo -e "${GRN}╚══════════════════════════════════════════════════════╝${NC}"
echo -e "${CYAN}Memulai ulang sesi terminal ke Zsh...${NC}\n"

exec zsh
