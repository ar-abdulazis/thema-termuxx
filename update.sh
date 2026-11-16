#!/data/data/com.termux/files/usr/bin/bash

CYAN='\033[1;36m'
YEL='\033[1;33m'
GRN='\033[1;32m'
RED='\033[1;31m'
NC='\033[0m'

REPO_RAW="https://raw.githubusercontent.com/ar-abdulazis/thema-termuxx/main"

echo -e "${CYAN}╔══════════════════════════════════════════════════════╗${NC}"
echo -e "${CYAN}   ⚡ MEMPERBARUI THEMA-TERMUXx KE VERSI TERBARU ⚡    ${NC}"
echo -e "${CYAN}╚══════════════════════════════════════════════════════╝${NC}"

echo -e "\n${YEL}[1/3] Mencadangkan konfigurasi lama...${NC}"
[ -f "$HOME/.zshrc" ] && cp "$HOME/.zshrc" "$HOME/.zshrc.bak_update"

echo -e "${YEL}[2/3] Mengunduh berkas terbaru langsung dari GitHub...${NC}"
mkdir -p "$HOME/.termux"
curl -fsSL "$REPO_RAW/.zshrc" -o "$HOME/.zshrc"
curl -fsSL "$REPO_RAW/colors.properties" -o "$HOME/.termux/colors.properties"
curl -fsSL "$REPO_RAW/termux.properties" -o "$HOME/.termux/termux.properties"
curl -fsSL "$REPO_RAW/font.ttf" -o "$HOME/.termux/font.ttf"

echo -e "${YEL}[3/3] Menyegarkan (refresh) tampilan & sesi terminal...${NC}"
termux-reload-settings

echo -e "\n${GRN}╔══════════════════════════════════════════════════════╗${NC}"
echo -e "${GRN}║  [✔] PEMBARUAN BERHASIL & TERMINAL DI-REFRESH!       ║${NC}"
echo -e "${GRN}╚══════════════════════════════════════════════════════╝${NC}\n"

# Otomatis refresh shell agar alias baru langsung aktif
exec zsh