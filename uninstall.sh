#!/data/data/com.termux/files/usr/bin/bash

CYAN='\033[1;36m'
YEL='\033[1;33m'
GRN='\033[1;32m'
RED='\033[1;31m'
NC='\033[0m'

ALIAS_CMD="alias restore-thema='[ -f ~/.zshrc.cybersmith.bak ] && mv ~/.zshrc.cybersmith.bak ~/.zshrc && sed -i \"/alias restore-thema=/d\" ~/.bashrc && chsh -s zsh && exec zsh || echo \"Cadangan tidak ditemukan!\"'"

echo -e "${YEL}╔══════════════════════════════════════════════════════╗${NC}"
echo -e "${RED}   ⚠️  RESET TAMPILAN TERMUX KE SETELAN AWAL  ⚠️       ${NC}"
echo -e "${YEL}╚══════════════════════════════════════════════════════╝${NC}"

read -p "Yakin ingin menghapus tema Cybersmith & kembali ke default? (y/n): " confirm
if [[ "$confirm" != "y" && "$confirm" != "Y" ]]; then
  echo -e "${CYAN}[!] Proses reset dibatalkan.${NC}"
  exit 0
fi

echo -e "\n${CYAN}--- Opsi Pencadangan Konfigurasi ---${NC}"
echo -e "  ${GRN}[y]${NC} Simpan cadangan (~/.zshrc.cybersmith.bak) -> Ketik 'restore-thema' di Bash untuk kembali."
echo -e "  ${RED}[n]${NC} Hapus permanen -> Bersihkan seluruh konfigurasi Cybersmith dari perangkat."
read -p "Simpan file cadangan konfigurasi saat ini? (y/n): " keep_bak

if [ -f "$HOME/.zshrc" ]; then
  if [[ "$keep_bak" == "y" || "$keep_bak" == "Y" ]]; then
    echo -e "\n${GRN}[1/4] Menyimpan cadangan konfigurasi & mendaftarkan perintah ke ~/.bashrc...${NC}"
    mv "$HOME/.zshrc" "$HOME/.zshrc.cybersmith.bak"
    touch "$HOME/.bashrc"
    sed -i '/alias restore-thema=/d' "$HOME/.bashrc"
    echo "$ALIAS_CMD" >> "$HOME/.bashrc"
  else
    echo -e "\n${RED}[1/4] Menghapus permanen file ~/.zshrc dan cadangan lama...${NC}"
    rm -f "$HOME/.zshrc" "$HOME/.zshrc.cybersmith.bak"
    [ -f "$HOME/.bashrc" ] && sed -i '/alias restore-thema=/d' "$HOME/.bashrc"
  fi
fi

echo -e "${YEL}[2/4] Menghapus warna, font, & properti kustom...${NC}"
rm -f "$HOME/.termux/colors.properties"
rm -f "$HOME/.termux/font.ttf"
rm -f "$HOME/.termux/termux.properties"

echo -e "${YEL}[3/4] Mengembalikan welcome screen bawaan Termux...${NC}"
rm -f "$HOME/.hushlogin"

echo -e "${YEL}[4/4] Mengembalikan default shell ke Bash...${NC}"
chsh -s bash

termux-reload-settings

echo -e "\n${GRN}╔══════════════════════════════════════════════════════╗${NC}"
echo -e "${GRN}║  [✔] TERMUX BERHASIL DIKEMBALIKAN KE SETELAN AWAL!   ║${NC}"
echo -e "${GRN}╚══════════════════════════════════════════════════════╝${NC}"
if [[ "$keep_bak" == "y" || "$keep_bak" == "Y" ]]; then
  echo -e "${CYAN}Info: Ketik 'restore-thema' kapan saja di mode Bash untuk memulihkan kembali.${NC}\n"
fi

exec bash