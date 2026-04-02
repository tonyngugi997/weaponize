#!/bin/bash
set -e

CYAN='\e[38;2;0;255;255m'
GREEN='\e[38;2;0;255;128m'
RED='\e[38;2;255;20;80m'
YELLOW='\e[38;2;255;220;100m'
BLUE='\e[38;2;50;150;255m'
PURPLE='\e[38;2;180;80;255m'
ORANGE='\e[38;2;255;128;0m'
PINK='\e[38;2;255;80;180m'
DARK='\e[38;2;40;40;50m'
NC='\e[0m'
BOLD='\e[1m'
BLINK='\e[5m'
HIDE_CURSOR='\e[?25l'
SHOW_CURSOR='\e[?25h'

trap "echo -e '$SHOW_CURSOR'; exit" INT TERM EXIT

# Hide cursor for clean UI
echo -e "$HIDE_CURSOR"

# Cyberpunk ascii header
show_header() {
    clear
    echo -e "${PURPLE}"
    cat << "EOF"
╔═══════════════════════════════════════════════════════════════╗
║  ██     ██ ███████  █████  ██████  ██████  ███    ██ ██ ███████╗ ███████╗
║  ██     ██ ██      ██   ██ ██   ██ ██   ██ ████   ██ ██ ██      ██      
║  ██  █  ██ █████   ███████ ██████  ██████  ██ ██  ██ ██ █████   ███████╗
║  ██ ███ ██ ██      ██   ██ ██      ██   ██ ██  ██ ██ ██ ██           ██║
║   ███ ███  ███████ ██   ██ ██      ██   ██ ██   ████ ██ ███████ ███████║
╚═══════════════════════════════════════════════════════════════╝
EOF
    echo -e "${NC}"
    echo -e "${CYAN}  ⚡ ADVANCED WEAPON SYSTEMS - INSTALLER v2.0 ⚡${NC}\n"
}

# Advanced spinner with 64 frames and color cycling
cyber_spinner() {
    local pid=$1
    local frames=('⣾' '⣽' '⣻' '⢿' '⡿' '⣟' '⣯' '⣷')
    local colors=("$CYAN" "$BLUE" "$PURPLE" "$PINK" "$CYAN")
    local i=0
    while kill -0 "$pid" 2>/dev/null; do
        printf "\r${colors[i%${#colors[@]}]}[%s]${NC}  " "${frames[i%${#frames[@]}]}"
        i=$((i+1))
        sleep 0.05
    done
    printf "\r${GREEN}[✔]${NC}  "
}

# Sleek progress bar with gradient
gradient_progress() {
    local duration=$1
    local steps=30
    local colors=(
        '\e[38;2;255;0;0m'      # Red
        '\e[38;2;255;64;0m'     # Orange-Red
        '\e[38;2;255;128;0m'    # Orange
        '\e[38;2;255;192;0m'    # Yellow-Orange
        '\e[38;2;255;255;0m'    # Yellow
        '\e[38;2;128;255;0m'    # Yellow-Green
        '\e[38;2;0;255;0m'      # Green
    )
    
    printf " "
    for ((i=0; i<=steps; i++)); do
        local percent=$((i * 100 / steps))
        local color_idx=$((i * (${#colors[@]}-1) / steps))
        printf "${colors[color_idx]}█${NC}"
        sleep $((duration * 100 / steps / 1000.0 2>/dev/null || echo "0.02"))
    done
    printf " ${GREEN}100%%${NC}"
}

rainbow_type() {
    local text="$1"
    local delay=${2:-0.02}
    local colors=("$RED" "$YELLOW" "$GREEN" "$CYAN" "$BLUE" "$PURPLE" "$PINK")
    local idx=0
    
    for ((i=0; i<${#text}; i++)); do
        char="${text:$i:1}"
        if [[ "$char" == $'\033'* ]]; then
            # Skip ANSI sequences
            printf "%s" "$char"
        else
            printf "${colors[idx % ${#colors[@]}]}%s${NC}" "$char"
            idx=$((idx+1))
            sleep "$delay"
        fi
    done
    echo ""
}

glitch_success() {
    local message="$1"
    printf "\r${RED}██ ${message}${NC}"
    sleep 0.05
    printf "\r${GREEN}▓▓ ${message}${NC}"
    sleep 0.05
    printf "\r${CYAN}▒▒ ${message}${NC}"
    sleep 0.05
    printf "\r${GREEN}✅ ${message}${NC}\n"
}

matrix_weaponize() {
    local text=">> WEAPONIZING SYSTEM <<"
    local chars=('0' '1' '⚡' '█' '▓' '▒' '░')
    
    for ((i=0; i<30; i++)); do
        echo -ne "\r${GREEN}"
        for ((j=0; j<${#text}; j++)); do
            if (( RANDOM % 5 < 2 )); then
                echo -ne "${chars[RANDOM % ${#chars[@]}]}"
            else
                echo -ne "${text:$j:1}"
            fi
        done
        echo -ne "${NC}"
        sleep 0.05
    done
    echo -e "\r${GREEN}${text}${NC} ✅"
}

show_header

rainbow_type "🔍 Initializing weapon systems..." 0.03
sleep 0.3
matrix_weaponize
sleep 0.3

# Backup old nvim config
printf "${CYAN}▶ SCANNING for existing configs...${NC} "
if [ -d "$HOME/.config/nvim" ]; then
    echo -e "\n${YELLOW}⚠ Old weapon configuration detected.${NC}"
    TIMESTAMP=$(date +"%Y-%m-%d_%H-%M-%S")
    
    rainbow_type "   → Archiving to time capsule..." 0.02
    mv "$HOME/.config/nvim" "$HOME/.config/nvim_backup_$TIMESTAMP" &
    cyber_spinner $!
    
    glitch_success "Backup secured → $HOME/.config/nvim_backup_$TIMESTAMP"
else
    echo -e "\n${GREEN}✓ Clean slate - no prior configs found${NC}"
fi

echo -e ""

# Prepare config directory
printf "${CYAN}▶ PREPARING battlefield...${NC} "
mkdir -p "$HOME/.config/nvim" &
cyber_spinner $!
glitch_success "Config directory deployed at $HOME/.config/nvim"

echo -e ""

# Copy config files 
rainbow_type "⚙️  DEPLOYING weaponize configs..." 0.03
printf "\n${CYAN}   ["
gradient_progress 1.5
echo -e "]${NC}\n"

cp init.lua "$HOME/.config/nvim/init.lua" &
cyber_spinner $!
glitch_success "Core weapon systems installed"

echo -e ""

# Final sequence
rainbow_type "🔥 FINALIZING weaponization..." 0.02
sleep 0.5

# Epic final banner
clear
show_header
echo -e "${GREEN}${BOLD}"
cat << "EOF"
   ▄▄▄▄▄▄▄▄▄▄▄  ▄▄▄▄▄▄▄▄▄▄▄  ▄▄▄▄▄▄▄▄▄▄▄  ▄▄▄▄▄▄▄▄▄▄▄ 
  ▐░░░░░░░░░░░▌▐░░░░░░░░░░░▌▐░░░░░░░░░░░▌▐░░░░░░░░░░░▌
  ▐░█▀▀▀▀▀▀▀█░▌▐░█▀▀▀▀▀▀▀█░▌▐░█▀▀▀▀▀▀▀█░▌▐░█▀▀▀▀▀▀▀█░▌
  ▐░▌       ▐░▌▐░▌       ▐░▌▐░▌       ▐░▌▐░▌       ▐░▌
  ▐░█▄▄▄▄▄▄▄█░▌▐░█▄▄▄▄▄▄▄█░▌▐░▌       ▐░▌▐░▌       ▐░▌
  ▐░░░░░░░░░░░▌▐░░░░░░░░░░░▌▐░▌       ▐░▌▐░▌       ▐░▌
  ▐░█▀▀▀▀▀▀▀█░▌▐░█▀▀▀▀▀▀▀█░▌▐░▌       ▐░▌▐░▌       ▐░▌
  ▐░▌       ▐░▌▐░▌       ▐░▌▐░█▄▄▄▄▄▄▄█░▌▐░█▄▄▄▄▄▄▄█░▌
  ▐░▌       ▐░▌▐░▌       ▐░▌▐░░░░░░░░░░░▌▐░░░░░░░░░░░▌
  ▀         ▀  ▀         ▀  ▀▀▀▀▀▀▀▀▀▀▀  ▀▀▀▀▀▀▀▀▀▀▀ 
EOF
echo -e "${NC}\n"

rainbow_type "🚀 ${GREEN}WEAPONIZE DEPLOYED SUCCESSFULLY${NC}" 0.04
echo -e "\n${CYAN}═══════════════════════════════════════════════════════════════${NC}"
echo -e "${BOLD}${GREEN}▶ Launch with:${NC} ${CYAN}nvim${NC}"
echo -e "${YELLOW}⚠ First boot: 30-60s (plugin installation)${NC}"
echo -e "${PURPLE}⚡ You are now weaponized. Go dominate.${NC}"
echo -e "${CYAN}═══════════════════════════════════════════════════════════════${NC}\n"

echo -e "$SHOW_CURSOR"