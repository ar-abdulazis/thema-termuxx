#!/data/data/com.termux/files/usr/bin/bash

CYAN='\033[1;36m'
YEL='\033[1;33m'
GRN='\033[1;32m'
RED='\033[1;31m'
NC='\033[0m'

echo -e "${YEL}╔══════════════════════════════════════════════════════╗${NC}"
echo -e "${RED}   ⚠️  RESET TAMPILAN TERMUX KE SETELAN AWAL  ⚠️       ${NC}"
echo -e "${YEL}╚══════════════════════════════════════════════════════╝${NC}"

# Konfirmasi keamanan sebelum reset
read -p "Yakin ingin menghapus tema Cybersmith & kembali ke default? (y/n): " confirm
if [[ "$confirm" != "y" && "$confirm" != "Y" ]]; then
  echo -e "${CYAN}[!] Proses reset dibatalkan.${NC}"
  exit 0
fi

# Opsi Penanganan File Cadangan (.zshrc.cybersmith.bak)
echo -e "\n${CYAN}--- Opsi Pencadangan Konfigurasi ---${NC}"
echo -e "  ${GRN}[y]${NC} Simpan cadangan (~/.zshrc.cybersmith.bak) -> Bisa dipulihkan instan nanti tanpa internet."
echo -e "  ${RED}[n]${NC} Hapus permanen -> Bersihkan seluruh konfigurasi Cybersmith dari perangkat."
read -p "Simpan file cadangan konfigurasi saat ini? (y/n): " keep_bak

if [ -f "$HOME/.zshrc" ]; then
  if [[ "$keep_bak" == "y" || "$keep_bak" == "Y" ]]; then
    echo -e "\n${GRN}[1/4] Menyimpan cadangan konfigurasi ke ~/.zshrc.cybersmith.bak...${NC}"
    mv "$HOME/.zshrc" "$HOME/.zshrc.cybersmith.bak"
  else
    echo -e "\n${RED}[1/4] Menghapus permanen file ~/.zshrc dan cadangan lama...${NC}"
    rm -f "$HOME/.zshrc" "$HOME/.zshrc.cybersmith.bak"
  fi
fi

# Hapus skema warna, font, dan properti kustom di folder .termux
echo -e "${YEL}[2/4] Menghapus warna, font, & properti kustom...${NC}"
rm -f "$HOME/.termux/colors.properties"
rm -f "$HOME/.termux/font.ttf"
rm -f "$HOME/.termux/termux.properties"

# Kembalikan pesan sambutan (MOTD) bawaan Termux
echo -e "${YEL}[3/4] Mengembalikan welcome screen bawaan Termux...${NC}"
rm -f "$HOME/.hushlogin"

# Kembalikan shell default dari Zsh ke Bash bawaan Termux
echo -e "${YEL}[4/4] Mengembalikan default shell ke Bash...${NC}"
chsh -s bash

termux-reload-settings

echo -e "\n${GRN}╔══════════════════════════════════════════════════════╗${NC}"
echo -e "${GRN}║  [✔] TERMUX BERHASIL DIKEMBALIKAN KE SETELAN AWAL!   ║${NC}"
echo -e "${GRN}╚══════════════════════════════════════════════════════╝${NC}"
if [[ "$keep_bak" == "y" || "$keep_bak" == "Y" ]]; then
  echo -e "${CYAN}Info: Ketik 'restore-thema' (atau jalankan install.sh) untuk memulihkan kembali.${NC}\n"
fi

exec bash