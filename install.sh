#!/bin/bash
set -e

BLOOD_RED='\e[38;2;255;0;30m'
TOXIC_GREEN='\e[38;2;0;255;100m'
NUCLEAR_ORANGE='\e[38;2;255;100;0m'
DARK_GREY='\e[38;2;80;80;90m'
FLARE_YELLOW='\e[38;2;255;200;0m'
CYBER_BLUE='\e[38;2;0;200;255m'
NC='\e[0m'
BOLD='\e[1m'
BLINK='\e[5m'
HIDE_CURSOR='\e[?25l'
SHOW_CURSOR='\e[?25h'

trap "echo -e '$SHOW_CURSOR'; exit" INT TERM EXIT
echo -e "$HIDE_CURSOR"
clear

cat << "EOF"
${BLOOD_RED}${BOLD}
╔══════════════════════════════════════════════════════════════════════════════╗
║                                                                              ║
║   ██     ██ ███████  █████  ██████  ██████  ███    ██ ██ ███████╗ ███████╗   ║
║   ██     ██ ██      ██   ██ ██   ██ ██   ██ ████   ██ ██ ██      ██         ║
║   ██  █  ██ █████   ███████ ██████  ██████  ██ ██  ██ ██ █████   ███████╗   ║
║   ██ ███ ██ ██      ██   ██ ██      ██   ██ ██  ██ ██ ██ ██           ██║   ║
║    ███ ███  ███████ ██   ██ ██      ██   ██ ██   ████ ██ ███████ ███████║   ║
║                                                                              ║
║                      ⚡ CODE IN YOUR POCKET ⚡                            ║
║                         AUTHOR: ${CYBER_BLUE}TONY NGUGI${BLOOD_RED} :localhost                         ║
╚══════════════════════════════════════════════════════════════════════════════╝
${NC}
EOF
echo -e "${DARK_GREY}══════════════════════════════════════════════════════════════════════════════${NC}\n"

rapid_fire() {
    local text="$1"
    local color="$2"
    local delay=${3:-0.008}
    
    echo -ne "${color}"
    for ((i=0; i<${#text}; i++)); do
        echo -n "${text:$i:1}"
        sleep "$delay"
    done
    echo -e "${NC}"
}

# ========== EXPLOSION ==========
explosion() {
    clear
    for i in {1..3}; do
        echo -e "${FLARE_YELLOW}💥 💥 💥${NC}"
        sleep 0.05
        echo -e "${BLOOD_RED}▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓${NC}"
        sleep 0.05
        clear
        sleep 0.05
    done
}

# ========== SCREEN SHAKE ==========
screen_shake() {
    local lines=$(tput lines)
    for i in {1..8}; do
        echo -en "\033[$(($RANDOM % 3 + 1));$(($RANDOM % 5 + 1))H"
        echo -en "${BLOOD_RED}██${NC}"
        sleep 0.02
    done
    clear
}

# ========== GLITCH ==========
glitch_text() {
    local text="$1"
    local color="$2"
    echo -ne "${color}"
    for ((i=0; i<${#text}; i++)); do
        if (( RANDOM % 8 < 2 )); then
            echo -ne "\033[2;3${RANDOM: -1}m${text:$i:1}\033[0m${color}"
        else
            echo -n "${text:$i:1}"
        fi
        sleep 0.01
    done
    echo -e "${NC}"
}

weapon_spinner() {
    local pid=$1
    local frames=('⚡' '💥' '🔫' '🗡️' '⚔️' '💣' '🔪' '⛓️')
    while kill -0 "$pid" 2>/dev/null; do
        for frame in "${frames[@]}"; do
            echo -ne "\r${BLOOD_RED}[${frame}]${NC} EXECUTING... "
            sleep 0.03
        done
    done
    echo -ne "\r${TOXIC_GREEN}[✔] COMPLETE     ${NC}\n"
}

hacking_progress() {
    local duration=$1
    local cols=$(tput cols)
    local lines=$(tput lines)
    
    echo -e "${TOXIC_GREEN}"
    for ((t=0; t<=20; t++)); do
        for i in {1..5}; do
            col=$((RANDOM % cols))
            echo -en "\033[${lines};${col}H"
            printf "%c" "$((RANDOM % 126 + 33))"
        done
        printf "\033[2;0H["
        for ((i=0; i<=t; i++)); do
            echo -n "█"
        done
        for ((i=t; i<20; i++)); do
            echo -n "░"
        done
        echo -n "] $((t*5))%"
        sleep 0.05
    done
    echo -e "${NC}"
    clear
}

# SIGNATURE ANIMATION 
author_signature() {
    clear
    echo -e "${CYBER_BLUE}"
    cat << "EOF"
╔══════════════════════════════════════════════════════════════╗
║                                                              ║
║     ████████╗ ██████╗ ███╗   ██╗██╗   ██╗                   ║
║     ╚══██╔══╝██╔═══██╗████╗  ██║╚██╗ ██╔╝                   ║
║        ██║   ██║   ██║██╔██╗ ██║ ╚████╔╝                    ║
║        ██║   ██║   ██║██║╚██╗██║  ╚██╔╝                     ║
║        ██║   ╚██████╔╝██║ ╚████║   ██║                      ║
║        ╚═╝    ╚═════╝ ╚═╝  ╚═══╝   ╚═╝                      ║
║                                                              ║
║                   ⚡ NGUGI WEAPON SYSTEMS ⚡                 ║
║                    localhost : Tony Ngugi                    ║
╚══════════════════════════════════════════════════════════════╝
EOF
    echo -e "${NC}"
    sleep 1
}

author_signature

rapid_fire ">> INITIATING WEAPON SEQUENCE <<" "$NUCLEAR_ORANGE" 0.01
sleep 0.3

screen_shake

rapid_fire ">> SCANNING TARGET ENVIRONMENT <<" "$DARK_GREY" 0.005
sleep 0.2

# Backup check
printf "${BLOOD_RED}[!]${NC} CHECKING FOR EXISTING CONFIGURATIONS... "
if [ -d "$HOME/.config/nvim" ]; then
    echo -e "\n${FLARE_YELLOW}[⚠] THREAT DETECTED - OLD CONFIG FOUND${NC}"
    TIMESTAMP=$(date +"%Y-%m-%d_%H-%M-%S")
    rapid_fire "   → NEUTRALIZING WITH EXTREME PREJUDICE..." "$BLOOD_RED" 0.002
    mv "$HOME/.config/nvim" "$HOME/.config/nvim_backup_$TIMESTAMP" &
    weapon_spinner $!
    glitch_text "   → CONTAINMENT SUCCESSFUL" "$TOXIC_GREEN"
else
    echo -e "${TOXIC_GREEN} CLEAN${NC}"
fi

echo ""

# Create directory
printf "${BLOOD_RED}[!]${NC} DEPLOYING BATTLEFIELD... "
mkdir -p "$HOME/.config/nvim" &
weapon_spinner $!
glitch_text "   → POSITION SECURED" "$TOXIC_GREEN"

echo ""

# Copy files
rapid_fire ">> LOADING WEAPON SYSTEMS <<" "$NUCLEAR_ORANGE" 0.008
hacking_progress 1

cp init.lua "$HOME/.config/nvim/init.lua" &
weapon_spinner $!

echo ""
explosion

clear
cat << "EOF"
${BLOOD_RED}${BOLD}
╔════════════════════════════════════════════════════════════════════╗
║                                                                    ║
║   ██     ██ ███████  █████  ██████  ██████  ███    ██ ██ ███████╗  ║
║   ██     ██ ██      ██   ██ ██   ██ ██   ██ ████   ██ ██ ██        ║
║   ██  █  ██ █████   ███████ ██████  ██████  ██ ██  ██ ██ █████     ║
║   ██ ███ ██ ██      ██   ██ ██      ██   ██ ██  ██ ██ ██ ██        ║
║    ███ ███  ███████ ██   ██ ██      ██   ██ ██   ████ ██ ███████   ║
║                                                                    ║
║                   ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━      ║
║                                                                   ║
║              ✅ DEPLOYED SUCCESSFULLY BY TONY NGUGI               ║
║                         🔥 LOCALHOST 🔥                           ║
║                                                                    ║
║                   YOU ARE NOW WEAPONIZED                          ║
║                    GO BUILD SOMETHING INSANE                      ║
║                                                                    ║
╚════════════════════════════════════════════════════════════════════╝
${NC}
EOF

echo -e "\n${TOXIC_GREEN}▶ LAUNCH:${NC} ${CYBER_BLUE}nvim${NC}"
echo -e "${FLARE_YELLOW}⚠ FIRST BOOT: 30-60s (ARMING PLUGINS)${NC}"
echo -e "${BLOOD_RED}⚡ YOU ARE NOW WEAPONIZED. GO DESTROY.${NC}\n"

echo -e "$SHOW_CURSOR"