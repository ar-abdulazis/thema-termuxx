#!/data/data/com.termux/files/usr/bin/bash

CYAN='\033[1;36m'
YEL='\033[1;33m'
GRN='\033[1;32m'
RED='\033[1;31m'
NC='\033[0m'

echo -e "${YEL}╔══════════════════════════════════════════════════════╗${NC}"
echo -e "${RED}   ⚠️  RESET TAMPILAN TERMUX KE SETELAN AWAL  ⚠️      ${NC}"
echo -e "${YEL}╚══════════════════════════════════════════════════════╝${NC}"

# Konfirmasi keamanan sebelum menghapus
read -p "Yakin ingin menghapus tema Cybersmith & kembali ke default? (y/n): " confirm
if [[ "$confirm" != "y" && "$confirm" != "Y" ]]; then
  echo -e "${CYAN}[!] Proses reset dibatalkan.${NC}"
  exit 0
fi

# 1. Backup konfigurasi saat ini sebelum dihapus (untuk berjaga-jaga)
echo -e "\n${YEL}[1/4] Mencadangkan konfigurasi lama ke ~/.zshrc.cybersmith.bak...${NC}"
[ -f "$HOME/.zshrc" ] && mv "$HOME/.zshrc" "$HOME/.zshrc.cybersmith.bak"

# 2. Hapus skema warna, font, dan properti kustom di folder .termux
echo -e "${YEL}[2/4] Menghapus warna, font, & properti kustom...${NC}"
rm -f "$HOME/.termux/colors.properties"
rm -f "$HOME/.termux/font.ttf"
rm -f "$HOME/.termux/termux.properties"

# 3. Kembalikan pesan sambutan (MOTD) bawaan Termux
echo -e "${YEL}[3/4] Mengembalikan welcome screen bawaan Termux...${NC}"
rm -f "$HOME/.hushlogin"

# 4. Kembalikan shell default dari Zsh ke Bash bawaan Termux
echo -e "${YEL}[4/4] Mengembalikan default shell ke Bash...${NC}"
chsh -s bash

# Terapkan perubahan visual Termux
termux-reload-settings

echo -e "\n${GRN}╔══════════════════════════════════════════════════════╗${NC}"
echo -e "${GRN}║  [✔] TERMUX BERHASIL DIKEMBALIKAN KE SETELAN AWAL!   ║${NC}"
echo -e "${GRN}╚══════════════════════════════════════════════════════╝${NC}"
echo -e "${CYAN}Memulai ulang sesi ke Bash standar...${NC}\n"

exec bash