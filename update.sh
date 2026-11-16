#!/data/data/com.termux/files/usr/bin/bash

CYAN='\033[1;36m'
YEL='\033[1;33m'
GRN='\033[1;32m'
RED='\033[1;31m'
NC='\033[0m'

echo -e "${CYAN}╔══════════════════════════════════════════════════════╗${NC}"
echo -e "${CYAN}   ⚡ MEMPERBARUI THEMA-TERMUXx KE VERSI TERBARU ⚡    ${NC}"
echo -e "${CYAN}╚══════════════════════════════════════════════════════╝${NC}"

TEMP_DIR="$HOME/.temp_update_thema"
rm -rf "$TEMP_DIR"

echo -e "\n${YEL}[1/3] Mengunduh pembaruan terbaru dari GitHub...${NC}"
git clone https://github.com/ar-abdulazis/thema-termuxx.git "$TEMP_DIR"

if [ $? -ne 0 ]; then
  echo -e "${RED}[✘] Gagal mengunduh pembaruan. Periksa koneksi internet Anda!${NC}"
  exit 1
fi

echo -e "\n${YEL}[2/3] Menerapkan pembaruan konfigurasi...${NC}"
ARCHIVE_FILE=$(find "$TEMP_DIR" -maxdepth 1 -name "*.tar.gz" | head -n 1)

if [ -n "$ARCHIVE_FILE" ]; then
  # Backup .zshrc lama sebelum diperbarui
  [ -f "$HOME/.zshrc" ] && cp "$HOME/.zshrc" "$HOME/.zshrc.bak_update"
  
  # Ekstrak ulang arsip tema terbaru
  tar -xzf "$ARCHIVE_FILE" -C "$HOME"
  echo -e "${GRN}[✔] Berkas konfigurasi berhasil diperbarui!${NC}"
else
  echo -e "${RED}[✘] Berkas arsip pembaruan tidak ditemukan di repositori!${NC}"
  rm -rf "$TEMP_DIR"
  exit 1
fi

rm -rf "$TEMP_DIR"

echo -e "\n${YEL}[3/3] Menyegarkan sesi terminal...${NC}"
termux-reload-settings

echo -e "\n${GRN}╔══════════════════════════════════════════════════════╗${NC}"
echo -e "${GRN}║  [✔] PEMBARUAN THEMA-TERMUXx BERHASIL DI-APPLY!      ║${NC}"
echo -e "${GRN}╚══════════════════════════════════════════════════════╝${NC}\n"

source ~/.zshrc