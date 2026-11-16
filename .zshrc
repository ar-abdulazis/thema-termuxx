# ==========================================
# CYBERSMITH - NEURAL TERMINAL v2.6
# ==========================================

export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME=""

plugins=(
  git
  zsh-autosuggestions
  zsh-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh

# ==========================================
# 1. CYBERSMITH - OPTIMIZED HEADER BANNER
# ==========================================

cybersmith_header() {
  local C_CYAN='\e[1;36m'
  local C_MAG='\e[1;35m'
  local C_YEL='\e[1;33m'
  local C_GRN='\e[1;32m'
  local C_GRAY='\e[1;90m'
  local C_RST='\e[0m'

  local RT_TIME=$(date '+%H:%M:%S')
  local RT_DATE=$(date '+%d %b %Y')
  local RT_STORAGE=$(df -h /data 2>/dev/null | awk 'NR==2 {print $4 "/" $2}')
  local RT_UPTIME=$(uptime 2>/dev/null | sed 's/.*up \([^,]*\), .*/\1/')
  local RT_PY=$(python --version 2>/dev/null | awk '{print "Py " $2}')
  [ -z "$RT_PY" ] && RT_PY="No Py"
  local RT_ARCH=$(uname -m)

  local RT_BATTERY="N/A"
  if command -v termux-battery-status &> /dev/null; then
    local b_pct=$(termux-battery-status 2>/dev/null | grep -o '"percentage":[0-9]*' | grep -o '[0-9]*')
    [ -n "$b_pct" ] && RT_BATTERY="${b_pct}%"
  fi

  echo -e "${C_MAG}╔════════════════════════════════════════════════════════╗${C_RST}"
  echo -e "${C_CYAN}   ______       __            _____           _ __  __  ${C_RST}"
  echo -e "${C_CYAN}  / ____/_   __/ /_  ___  _____ / ___/____ ___  (_)/ /_/ /_ ${C_RST}"
  echo -e "${C_MAG} / /   / / / / __ \/ _ \/ ___/ \__ \/ __ \`__ \/ / __/ __ \\${C_RST}"
  echo -e "${C_MAG}/ /___/ /_/ / /_/ /  __/ /    ___/ / / / / / / /_/ / / /${C_RST}"
  echo -e "${C_YEL}\____/\__, /_.___/\___/_/    /____/_/ /_/ /_/_/\__/_/ /_/ ${C_RST}"
  echo -e "${C_YEL}     /____/                      // NEURAL TERMINAL v2.6${C_RST}"
  echo -e "${C_MAG}╠════════════════════════════════════════════════════════╣${C_RST}"
  
  printf "${C_MAG}║${C_RST} ${C_CYAN}⚡ SYS  :${C_RST} %-16s ${C_CYAN}🕒 TIME  :${C_RST} ${C_YEL}%-15s${C_RST} ${C_MAG}║${C_RST}\n" "Termux" "$RT_TIME"
  printf "${C_MAG}║${C_RST} ${C_CYAN}💾 DISK :${C_RST} %-16s ${C_CYAN}📅 DATE  :${C_RST} ${C_YEL}%-15s${C_RST} ${C_MAG}║${C_RST}\n" "$RT_STORAGE" "$RT_DATE"
  printf "${C_MAG}║${C_RST} ${C_CYAN}🔋 BATT :${C_RST} %-16s ${C_CYAN}⏱️ UPTIME:${C_RST} ${C_YEL}%-15s${C_RST} ${C_MAG}║${C_RST}\n" "$RT_BATTERY" "$RT_UPTIME"
  printf "${C_MAG}║${C_RST} ${C_CYAN}🔧 ENV  :${C_RST} ${C_GRN}%-16s${C_RST} ${C_CYAN}📡 NODE  :${C_RST} ${C_YEL}%-15s${C_RST} ${C_MAG}║${C_RST}\n" "$RT_PY" "$RT_ARCH"
  
  echo -e "${C_MAG}╚════════════════════════════════════════════════════════╝${C_RST}"
  echo ""
}

# ==========================================
# 2. ANIMASI STARTUP & PENGATURAN CLEAR
# ==========================================

if [ -z "$CYBERSMITH_LOADED" ]; then
  export CYBERSMITH_LOADED="1"
  clear
  if command -v gum &> /dev/null; then
    gum spin --spinner.foreground="cyan" --title="Initializing Cybersmith Neural Link..." -- sleep 0.8
  fi
fi

command clear
cybersmith_header

unalias clear 2>/dev/null

clear() {
  command clear
  cybersmith_header
}

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

PROMPT=$'%F{cyan}┌─[%f%F{yellow}%*%f%F{cyan}]─[%f%F{green}%~%f%F{cyan}]%f${vcs_info_msg_0_}\n%F{cyan}└─▶%f '

# ==========================================
# 4. CUSTOM ALIASES
# ==========================================

alias ..='cd ..'
alias ...='cd ../..'
alias ll='ls -lah --color=auto'
alias c='clear'
alias sd='cd /sdcard'
alias dl='cd /sdcard/Download'
alias rc='nano ~/.zshrc'
alias rl='source ~/.zshrc'
alias tc='nano ~/.termux/colors.properties'
alias zshrc='nano ~/.zshrc'
alias reload='source ~/.zshrc'
alias termcolors='nano ~/.termux/colors.properties'
alias up='pkg update && pkg upgrade -y'
alias ins='pkg install'
alias py='python'
alias pyhttp='python -m http.server 8080'
alias gs='git status'
alias ga='git add .'
alias gc='git commit -m'
alias gp='git push'
alias gl='git log --oneline --graph --all'
alias dotfiles='git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
alias update-thema='exec bash -c "$(curl -fsSL https://raw.githubusercontent.com/ar-abdulazis/thema-termuxx/main/update.sh)"'
alias reset-thema='exec bash -c "$(curl -fsSL https://raw.githubusercontent.com/ar-abdulazis/thema-termuxx/main/uninstall.sh)"'

# ==========================================
# 5. INTERACTIVE THEME SELECTOR (FZF & GUM)
# ==========================================

themes() {
  if ! command -v gum &> /dev/null || ! command -v fzf &> /dev/null; then
    echo -e "\e[1;33m[!] Menginstal 'gum' & 'fzf' untuk menu interaktif...\e[0m"
    pkg install gum fzf -y
  fi

  local CHOICE=$(gum choose \
    "⚡ Cybersmith Cyberfunk (Cyan & Magenta)" \
    "🔋 Matrix Green (Classic Hacker)" \
    "🔥 Amber Terminal (Retro Fallout Style)" \
    "❄️ Cyber Blue Deep" \
    "❌ Batalkan")

  case "$CHOICE" in
    *"Cyberfunk"*)
      cat << 'EOF' > ~/.termux/colors.properties
background=#0f0e17
foreground=#05d9e8
cursor=#ff2a6d
color0=#1b1a29
color1=#ff2a6d
color2=#00ff66
color3=#ffb000
color4=#05d9e8
color5=#b57edd
color6=#799fff
color7=#fffffe
color8=#7f7f8a
color9=#ff5c8d
color10=#33ff88
color11=#ffc44d
color12=#33e1ee
color13=#cbb2ed
color14=#9cbaff
color15=#ffffff
EOF
      ;;
    *"Matrix Green"*)
      cat << 'EOF' > ~/.termux/colors.properties
background=#0d0d0d
foreground=#00ff66
cursor=#00ff66
color0=#1a1a1a
color1=#ff0033
color2=#00ff66
color3=#ffb000
color4=#0080ff
color5=#cc00ff
color6=#00ffff
color7=#ffffff
color8=#666666
color9=#ff3366
color10=#33ff88
color11=#ffc44d
color12=#3399ff
color13=#e64dff
color14=#80ffff
color15=#ffffff
EOF
      ;;
    *"Amber Terminal"*)
      cat << 'EOF' > ~/.termux/colors.properties
background=#14120f
foreground=#ffb000
cursor=#ffb000
color0=#26221c
color1=#ff4500
color2=#99cc00
color3=#ffb000
color4=#3366cc
color5=#9933cc
color6=#00cccc
color7=#ffeedd
color8=#665c54
color9=#ff6633
color10=#b3ff33
color11=#ffc740
color12=#5c85d6
color13=#b366ff
color14=#33cccc
color15=#ffffff
EOF
      ;;
    *"Cyber Blue Deep"*)
      cat << 'EOF' > ~/.termux/colors.properties
background=#0b1329
foreground=#799fff
cursor=#05d9e8
color0=#121d3b
color1=#ff2a6d
color2=#00ffcc
color3=#ffb000
color4=#3366ff
color5=#b57edd
color6=#05d9e8
color7=#ffffff
color8=#4a5c8c
color9=#ff5c8d
color10=#33ffdd
color11=#ffc44d
color12=#668cff
color13=#cbb2ed
color14=#33e1ee
color15=#ffffff
EOF
      ;;
    *)
      echo "Dibatalkan."
      return
      ;;
  esac

  termux-reload-settings
  echo -e "\e[1;32m[✔] Tema diterapkan! Menyegarkan sesi...\e[0m"
  sleep 0.5
  exec zsh
}

# ==========================================
# 6. BACKUP & RESTORE CONFIG
# ==========================================

unalias backup-termux restore-termux restore-thema reset-termux 2>/dev/null

backup-termux() {
  local BACKUP_DIR="/sdcard/Download/Termux_Backup"
  local ARCHIVE_NAME="cybersmith_config_$(date +%Y%m%d_%H%M%S).tar.gz"

  mkdir -p "$BACKUP_DIR"
  pkg list-installed > ~/.termux/installed_packages.txt 2>/dev/null
  tar -czf "$BACKUP_DIR/$ARCHIVE_NAME" -C ~ .zshrc .termux .hushlogin 2>/dev/null

  echo -e "\e[1;32m[✔] Backup berhasil disimpan di $BACKUP_DIR/$ARCHIVE_NAME\e[0m"
}

restore-termux() {
  local BACKUP_DIR="/sdcard/Download/Termux_Backup"
  local LATEST_BACKUP=$(ls -t "$BACKUP_DIR"/cybersmith_config_*.tar.gz 2>/dev/null | head -n 1)

  if [ -z "$LATEST_BACKUP" ]; then
    echo -e "\e[1;31m[✘] File backup tidak ditemukan!\e[0m"
    return 1
  fi

  tar -xzf "$LATEST_BACKUP" -C ~
  termux-reload-settings
  exec zsh
}

restore-thema() {
  local BAK_FILE="$HOME/.zshrc.cybersmith.bak"

  if [ ! -f "$BAK_FILE" ]; then
    echo -e "\e[1;31m[✘] File cadangan (.zshrc.cybersmith.bak) tidak ditemukan!\e[0m"
    return 1
  fi

  echo -e "\e[1;33m[!] Memulihkan konfigurasi tema Cybersmith dari cadangan lokal...\e[0m"
  mv "$BAK_FILE" "$HOME/.zshrc"
  [ -f "$HOME/.bashrc" ] && sed -i '/alias restore-thema=/d' "$HOME/.bashrc"
  chsh -s zsh
  termux-reload-settings
  echo -e "\e[1;32m[✔] Tema Cybersmith berhasil dipulihkan!\e[0m"
  sleep 0.5
  exec zsh
}

reset-termux() {
  local ALIAS_CMD="alias restore-thema='[ -f ~/.zshrc.cybersmith.bak ] && mv ~/.zshrc.cybersmith.bak ~/.zshrc && sed -i \"/alias restore-thema=/d\" ~/.bashrc && chsh -s zsh && exec zsh || echo \"Cadangan tidak ditemukan!\"'"

  echo -e "\e[1;33m[!] Mengembalikan Termux ke setelan awal (Offline Reset)...\e[0m"
  read "keep_bak?Simpan cadangan ~/.zshrc.cybersmith.bak agar bisa di-restore nanti? (y/n): "

  if [ -f "$HOME/.zshrc" ]; then
    if [[ "$keep_bak" == "y" || "$keep_bak" == "Y" ]]; then
      mv "$HOME/.zshrc" "$HOME/.zshrc.cybersmith.bak"
      touch "$HOME/.bashrc"
      sed -i '/alias restore-thema=/d' "$HOME/.bashrc"
      echo "$ALIAS_CMD" >> "$HOME/.bashrc"
      echo -e "\e[1;32m[✔] Cadangan disimpan & 'restore-thema' aktif di mode Bash.\e[0m"
    else
      rm -f "$HOME/.zshrc" "$HOME/.zshrc.cybersmith.bak"
      [ -f "$HOME/.bashrc" ] && sed -i '/alias restore-thema=/d' "$HOME/.bashrc"
      echo -e "\e[1;31m[✔] Konfigurasi dihapus permanen.\e[0m"
    fi
  fi

  rm -f "$HOME/.termux/colors.properties" "$HOME/.termux/font.ttf" "$HOME/.termux/termux.properties" "$HOME/.hushlogin"
  chsh -s bash
  termux-reload-settings
  exec bash
}

# --- Fitur Pemulihan Tema dari Cadangan Reset ---
restore-thema() {
  local BAK_FILE="$HOME/.zshrc.cybersmith.bak"
  
  if [ ! -f "$BAK_FILE" ]; then
    echo -e "\e[1;31m[✘] File cadangan (.zshrc.cybersmith.bak) tidak ditemukan!\e[0m"
    return 1
  fi

  echo -e "\e[1;33m[!] Memulihkan konfigurasi tema Cybersmith dari cadangan...\e[0m"
  
  # Kembalikan file .zshrc dari cadangan
  mv "$BAK_FILE" "$HOME/.zshrc"
  
  # Ubah default shell kembali ke Zsh
  chsh -s zsh
  
  # Terapkan pengaturan & muat ulang sesi
  termux-reload-settings
  echo -e "\e[1;32m[✔] Tema Cybersmith berhasil dipulihkan!\e[0m"
  sleep 0.8
  exec zsh
}