# ==========================================
# CYBERSMITH - NEURAL TERMINAL v2.6
# ==========================================

# Path instalasi Oh My Zsh
export ZSH="$HOME/.oh-my-zsh"

# Kosongkan tema bawaan agar tidak bentrok dengan prompt kustom
ZSH_THEME=""

# Daftar plugin yang aktif
plugins=(
  git
  zsh-autosuggestions
  zsh-syntax-highlighting
)

# Memuat konfigurasi utama Oh My Zsh
source $ZSH/oh-my-zsh.sh


# ==========================================
# 1. CYBERSMITH - CYBERFUNK HEADER BANNER
# ==========================================

cybersmith_header() {
  # Definisi Warna Neon Cyberpunk
  local C_CYAN='\e[1;36m'
  local C_MAG='\e[1;35m'
  local C_YEL='\e[1;33m'
  local C_GRN='\e[1;32m'
  local C_GRAY='\e[1;90m'
  local C_RST='\e[0m'

  # Informasi Sistem Real-Time
  local RT_TIME=$(date '+%H:%M:%S')
  local RT_DATE=$(date '+%d %b %Y')
  local RT_STORAGE=$(df -h /data 2>/dev/null | awk 'NR==2 {print $4 "/" $2}')
  local RT_PY=$(python --version 2>/dev/null | awk '{print "Py " $2}')
  [ -z "$RT_PY" ] && RT_PY="No Py"
  local RT_ARCH=$(uname -m)

  echo -e "${C_MAG}╔════════════════════════════════════════════════════════╗${C_RST}"
  echo -e "${C_CYAN}   ______      __               _____           _ __  __  ${C_RST}"
  echo -e "${C_CYAN}  / ____/_  __/ /_  ___  _____ / ___/____ ___  (_) /_/ /_ ${C_RST}"
  echo -e "${C_MAG} / /   / / / / __ \/ _ \/ ___/ \__ \/ __ \`__ \/ / __/ __ \\${C_RST}"
  echo -e "${C_MAG}/ /___/ /_/ / /_/ /  __/ /    ___/ / / / / / / / /_/ / / /${C_RST}"
  echo -e "${C_YEL}\____/\__, /_.___/\___/_/    /____/_/ /_/ /_/_/\__/_/ /_/ ${C_RST}"
  echo -e "${C_YEL}     /____/                  ${C_GRAY}// NEURAL TERMINAL v2.6${C_RST}"
  echo -e "${C_MAG}╠════════════════════════════════════════════════════════╣${C_RST}"
  
  # Menggunakan printf agar garis kanan (║) selalu lurus & simetris
  printf "${C_MAG}║${C_RST} ${C_CYAN}⚡ SYS :${C_RST} %-16s ${C_CYAN}🕒 TIME :${C_RST} ${C_YEL}%-16s${C_RST} ${C_MAG}║${C_RST}\n" "Termux ($ZSH_NAME)" "$RT_TIME"
  printf "${C_MAG}║${C_RST} ${C_CYAN}💾 DISK:${C_RST} %-16s ${C_CYAN}📅 DATE :${C_RST} %-16s ${C_MAG}║${C_RST}\n" "$RT_STORAGE" "$RT_DATE"
  printf "${C_MAG}║${C_RST} ${C_CYAN}🔧 ENV :${C_RST} ${C_GRN}%-16s${C_RST} ${C_CYAN}📡 NODE :${C_RST} %-16s ${C_MAG}║${C_RST}\n" "$RT_PY | Git" "$RT_ARCH"
  
  echo -e "${C_MAG}╚════════════════════════════════════════════════════════╝${C_RST}"
  echo ""
}

# Tampilkan banner saat pertama kali terminal dibuka
command clear
cybersmith_header


# ==========================================
# 2. ANTI-CLEAR & CTRL+L (BANNER TETAP MUNCUL)
# ==========================================

unalias clear 2>/dev/null

# Override perintah 'clear' agar banner otomatis digambar ulang di atas
clear() {
  command clear
  cybersmith_header
}

# Override tombol Ctrl+L agar memanggil fungsi clear di atas
cybersmith-clear-widget() {
  clear
  zle reset-prompt
}
zle -N cybersmith-clear-widget
bindkey '^L' cybersmith-clear-widget


# ==========================================
# 3. PROMPT & GIT VCS INFO
# ==========================================

setopt PROMPT_SUBST

autoload -Uz vcs_info
autoload -Uz add-zsh-hook
precmd_vcs_info() { vcs_info }
add-zsh-hook precmd precmd_vcs_info

zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:*' unstagedstr '*'
zstyle ':vcs_info:*' stagedstr '+'
zstyle ':vcs_info:git:*' formats ' %F{magenta}(git:%b%u%c)%f'

# Custom Prompt Dua Baris Neon
PROMPT=$'%F{cyan}┌─[%f%F{yellow}%*%f%F{cyan}]─[%f%F{green}%~%f%F{cyan}]%f${vcs_info_msg_0_}\n%F{cyan}└─▶%f '


# ==========================================
# 4. CYBERSMITH - CUSTOM ALIASES
# ==========================================

# --- Navigasi & Manajemen File ---
alias ..='cd ..'
alias ...='cd ../..'
alias ll='ls -lah --color=auto'
alias c='clear'
alias sd='cd /sdcard'
alias dl='cd /sdcard/Download'

# --- Edit & Muat Ulang Konfigurasi Cepat ---
alias rc='nano ~/.zshrc'
alias rl='source ~/.zshrc'
alias tc='nano ~/.termux/colors.properties'
alias zshrc='nano ~/.zshrc'
alias reload='source ~/.zshrc'
alias termcolors='nano ~/.termux/colors.properties'

# --- Paket & Sistem Termux ---
alias up='pkg update && pkg upgrade -y'
alias ins='pkg install'

# --- Coding & Python ---
alias py='python'
alias pyhttp='python -m http.server 8080'

# --- Git & Dotfiles Shortcut ---
alias gs='git status'
alias ga='git add .'
alias gc='git commit -m'
alias gp='git push'
alias gl='git log --oneline --graph --all'
alias dotfiles='git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'


# ==========================================
# 5. CYBERSMITH - BACKUP & RESTORE CONFIG
# ==========================================

# Perintah untuk membuat backup lengkap ke folder Download HP
backup-termux() {
  local BACKUP_DIR="/sdcard/Download/Termux_Backup"
  local ARCHIVE_NAME="cybersmith_config_$(date +%Y%m%d_%H%M%S).tar.gz"

  mkdir -p "$BACKUP_DIR"

  # Simpan daftar paket pkg yang terinstal saat ini
  pkg list-installed > ~/.termux/installed_packages.txt 2>/dev/null

  # Arsipkan file konfigurasi utama & folder .termux
  tar -czf "$BACKUP_DIR/$ARCHIVE_NAME" -C ~ .zshrc .termux .hushlogin 2>/dev/null

  echo -e "\e[1;32m[✔] Backup berhasil disimpan di:\e[0m"
  echo -e "\e[1;36m    $BACKUP_DIR/$ARCHIVE_NAME\e[0m"
}

# Perintah untuk memulihkan konfigurasi dari file backup terbaru
restore-termux() {
  local BACKUP_DIR="/sdcard/Download/Termux_Backup"
  local LATEST_BACKUP=$(ls -t "$BACKUP_DIR"/cybersmith_config_*.tar.gz 2>/dev/null | head -n 1)

  if [ -z "$LATEST_BACKUP" ]; then
    echo -e "\e[1;31m[✘] File backup tidak ditemukan di $BACKUP_DIR\e[0m"
    return 1
  fi

  echo -e "\e[1;33m[!] Memulihkan dari: $LATEST_BACKUP\e[0m"
  tar -xzf "$LATEST_BACKUP" -C ~
  termux-reload-settings
  source ~/.zshrc
  echo -e "\e[1;32m[✔] Konfigurasi Cybersmith berhasil dipulihkan!\e[0m"
}
