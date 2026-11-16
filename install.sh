#!/data/data/com.termux/files/usr/bin/bash

CYAN='\033[1;36m'
MAG='\033[1;35m'
GRN='\033[1;32m'
YEL='\033[1;33m'
RED='\033[1;31m'
NC='\033[0m'

REPO_RAW="https://raw.githubusercontent.com/ar-abdulazis/thema-termuxx/main"

echo -e "${MAG}╔══════════════════════════════════════════════════════╗${NC}"
echo -e "${CYAN}   ⚡ INSTALLER THEMA-TERMUXx (CYBERSMITH EDITION) ⚡   ${NC}"
echo -e "${MAG}╚══════════════════════════════════════════════════════╝${NC}"

# 1. Update & Pengecekan Paket Dasar + UI Tools (fzf & gum)
echo -e "\n${YEL}[1/6] Memeriksa paket dasar & komponen UI (fzf, gum)...${NC}"
pkg update -y && pkg upgrade -y

PACKAGES=(git curl zsh nano python tar fzf gum termux-api)
MISSING_PKGS=()

for pkg_name in "${PACKAGES[@]}"; do
  if ! command -v "$pkg_name" &> /dev/null && ! dpkg -s "$pkg_name" &> /dev/null; then
    MISSING_PKGS+=("$pkg_name")
  fi
done

if [ ${#MISSING_PKGS[@]} -gt 0 ]; then
  echo -e "${YEL}      Menginstal paket yang belum tersedia: ${MISSING_PKGS[*]}...${NC}"
  pkg install -y "${MISSING_PKGS[@]}"
else
  echo -e "${GRN}[✔] Semua paket dasar, fzf, dan gum sudah terpasang! Lanjut...${NC}"
fi

# 2. Setup Izin Storage
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
else
  echo -e "${GRN}      Plugin zsh-autosuggestions sudah terpasang.${NC}"
fi

if [ ! -d "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting" ]; then
  git clone https://github.com/zsh-users/zsh-syntax-highlighting "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting"
else
  echo -e "${GRN}      Plugin zsh-syntax-highlighting sudah terpasang.${NC}"
fi

# 5. Unduh Konfigurasi Terbaru Langsung dari Repositori GitHub
echo -e "\n${YEL}[5/6] Mengunduh konfigurasi terbaru Cybersmith...${NC}"
[ -f "$HOME/.zshrc" ] && cp "$HOME/.zshrc" "$HOME/.zshrc.bak_$(date +%Y%m%d)"
mkdir -p "$HOME/.termux"

curl -fsSL "$REPO_RAW/.zshrc" -o "$HOME/.zshrc"
curl -fsSL "$REPO_RAW/colors.properties" -o "$HOME/.termux/colors.properties"
curl -fsSL "$REPO_RAW/termux.properties" -o "$HOME/.termux/termux.properties"
curl -fsSL "$REPO_RAW/font.ttf" -o "$HOME/.termux/font.ttf"

echo -e "${GRN}[✔] Berkas konfigurasi berhasil diunduh dan diterapkan!${NC}"

# 6. Ubah Default Shell ke Zsh & Terapkan Pengaturan
echo -e "\n${YEL}[6/6] Menerapkan pengaturan akhir...${NC}"
chsh -s zsh
termux-reload-settings

echo -e "\n${GRN}╔══════════════════════════════════════════════════════╗${NC}"
echo -e "${GRN}║  [✔] INSTALASI THEMA-TERMUXx SELESAI!                ║${NC}"
echo -e "${GRN}╚══════════════════════════════════════════════════════╝${NC}"
echo -e "${CYAN}Memulai ulang sesi terminal ke Zsh...${NC}\n"

exec zsh