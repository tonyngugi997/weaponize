#!/bin/bash
# ============================================================================
# WEAPONIZE - CUSTOM TERMUX STYLING
# ============================================================================
# This script is SOURCED from install.sh (not run standalone)
# It transforms Termux into a hacker-style terminal
# ============================================================================

# Colors (matching install.sh)
BLOOD_RED='\e[38;2;255;0;30m'
TOXIC_GREEN='\e[38;2;0;255;100m'
CYBER_BLUE='\e[38;2;0;200;255m'
FLARE_YELLOW='\e[38;2;255;200;0m'
DARK_GREY='\e[38;2;80;80;90m'
NC='\e[0m'
BOLD='\e[1m'

echo ""

# ============================================================================
# 1. BACKUP EXISTING TERMUX CONFIG
# ============================================================================
BACKUP_DIR="$HOME/.termux.backup.$(date +%Y%m%d_%H%M%S)"

if [ -d "$HOME/.termux" ] || [ -f "$HOME/.bashrc" ]; then
    echo -e "${FLARE_YELLOW}[!] Backing up existing Termux configuration...${NC}"
    mkdir -p "$BACKUP_DIR"
    
    [ -d "$HOME/.termux" ] && cp -r "$HOME/.termux" "$BACKUP_DIR/"
    [ -f "$HOME/.bashrc" ] && cp "$HOME/.bashrc" "$BACKUP_DIR/"
    
    echo -e "${TOXIC_GREEN}✅ Backup saved to: $BACKUP_DIR${NC}"
fi

# ============================================================================
# 2. ASK FOR HACKER HANDLE
# ============================================================================
echo ""
echo -e "${CYBER_BLUE}┌─────────────────────────────────────────────────────────────────┐${NC}"
echo -e "${CYBER_BLUE}│${NC} ${FLARE_YELLOW}⚡ ENTER YOUR HACKER HANDLE${NC}"
echo -e "${CYBER_BLUE}├─────────────────────────────────────────────────────────────────┤${NC}"
echo -ne "${CYBER_BLUE}│${NC} ${TOXIC_GREEN}> ${NC}"
read HACKER_NAME

if [ -z "$HACKER_NAME" ]; then
    HACKER_NAME="weapon"
    echo -e "${FLARE_YELLOW}   Using default: $HACKER_NAME${NC}"
fi
echo -e "${CYBER_BLUE}└─────────────────────────────────────────────────────────────────┘${NC}"

# ============================================================================
# 3. ASK FOR COLOR SCHEME
# ============================================================================
echo ""
echo -e "${CYBER_BLUE}┌─────────────────────────────────────────────────────────────────┐${NC}"
echo -e "${CYBER_BLUE}│${NC} ${FLARE_YELLOW}🎨 SELECT YOUR COLOR SCHEME${NC}"
echo -e "${CYBER_BLUE}├─────────────────────────────────────────────────────────────────┤${NC}"
echo -e "${CYBER_BLUE}│${NC}                                                               │"
echo -e "${CYBER_BLUE}│${NC}   ${BLOOD_RED}1. BLOOD RED     - Aggressive, warning style${NC}"
echo -e "${CYBER_BLUE}│${NC}   ${TOXIC_GREEN}2. TOXIC GREEN   - Classic Matrix hacker vibe${NC}"
echo -e "${CYBER_BLUE}│${NC}   ${CYBER_BLUE}3. CYBER BLUE    - Neon cyberpunk aesthetic${NC}"
echo -e "${CYBER_BLUE}│${NC}   \e[38;2;180;80;255m4. PURPLE HAZE   - Synthwave retro vibe${NC}"
echo -e "${CYBER_BLUE}│${NC}   \e[38;2;255;128;0m5. NUCLEAR AMBER - Old school terminal feel${NC}"
echo -e "${CYBER_BLUE}│${NC}                                                               │"
echo -e "${CYBER_BLUE}├─────────────────────────────────────────────────────────────────┤${NC}"
echo -ne "${CYBER_BLUE}│${NC} ${TOXIC_GREEN}Enter choice (1-5): ${NC}"
read COLOR_CHOICE

case $COLOR_CHOICE in
    1) PROMPT_COLOR="$BLOOD_RED" ;;
    2) PROMPT_COLOR="$TOXIC_GREEN" ;;
    3) PROMPT_COLOR="$CYBER_BLUE" ;;
    4) PROMPT_COLOR='\e[38;2;180;80;255m' ;;
    5) PROMPT_COLOR='\e[38;2;255;128;0m' ;;
    *) PROMPT_COLOR="$TOXIC_GREEN" ;;
esac
echo -e "${CYBER_BLUE}└─────────────────────────────────────────────────────────────────┘${NC}"

# ============================================================================
# 4. ASK FOR EXTRA FEATURES
# ============================================================================
echo ""
echo -e "${CYBER_BLUE}┌─────────────────────────────────────────────────────────────────┐${NC}"
echo -e "${CYBER_BLUE}│${NC} ${FLARE_YELLOW}🔧 ADDITIONAL FEATURES${NC}"
echo -e "${CYBER_BLUE}├─────────────────────────────────────────────────────────────────┤${NC}"

read -p "$(echo -e "${CYBER_BLUE}│${NC} Install custom Nerd Font? (y/N): ")" INSTALL_FONT
read -p "$(echo -e "${CYBER_BLUE}│${NC} Enable boot animation? (Y/n): ")" BOOT_ANIMATION
read -p "$(echo -e "${CYBER_BLUE}│${NC} Enable Matrix screensaver? (y/N): ")" MATRIX_SAVER

echo -e "${CYBER_BLUE}└─────────────────────────────────────────────────────────────────┘${NC}"

# ============================================================================
# 5. GENERATE .BASHRC
# ============================================================================
echo ""
echo -e "${FLARE_YELLOW}[!] Generating custom .bashrc...${NC}"

# Start fresh .bashrc
cat > "$HOME/.bashrc" << 'BASHRC_START'
# ============================================================================
# WEAPONIZE - HACKER EDITION
# ============================================================================

BASHRC_START

# Add color scheme
cat >> "$HOME/.bashrc" << EOF
# Color scheme
PS1_COLOR='${PROMPT_COLOR}'
NC='\e[0m'

EOF

# Add git branch function
cat >> "$HOME/.bashrc" << 'BASHRC_GIT'
# Git branch for prompt
parse_git_branch() {
    git branch 2>/dev/null | grep '*' | sed 's/* //'
}

BASHRC_GIT

# Add custom prompt
cat >> "$HOME/.bashrc" << 'BASHRC_PROMPT'
# Main weaponized prompt
export PS1="\n┌─[ ${PS1_COLOR}\u@weaponize${NC} ]─[ ${PS1_COLOR}\w${NC} ]\$(parse_git_branch > /dev/null && echo \"─[ \$(parse_git_branch) ]\")\n└──╼ \$ "

BASHRC_PROMPT

# Add aliases
cat >> "$HOME/.bashrc" << 'BASHRC_ALIASES'
# Weaponized aliases
alias ll='ls -la'
alias cls='clear'
alias ..='cd ..'
alias ...='cd ../..'
alias weaponize='nvim'
alias hack='nvim'

BASHRC_ALIASES

# Add boot animation
if [[ "$BOOT_ANIMATION" =~ ^[Yy]$ ]]; then
    cat >> "$HOME/.bashrc" << 'BASHRC_BOOT'
# Boot animation
clear
echo -e "\e[38;2;0;255;100m"
cat << "BOOT"
┌─────────────────────────────────────────────────────────────────┐
│  ⚡ WEAPONIZE TERMINAL v1.0                                     │
│  "Your Android is now a weapon."                               │
└─────────────────────────────────────────────────────────────────┘
BOOT
echo -e "\e[0m"
echo -e "\e[38;2;0;255;100mWeaponizing system... ████████████████████ 100%\e[0m"
echo ""
echo -e "\e[38;2;255;200;0mLast login: $(date)\e[0m"
echo "───────────────────────────────────────────────────────────────────"
echo ""
BASHRC_BOOT
fi

# Add Matrix screensaver
if [[ "$MATRIX_SAVER" =~ ^[Yy]$ ]]; then
    cat >> "$HOME/.bashrc" << 'BASHRC_MATRIX'
# Simple Matrix screensaver (manual trigger)
matrix() {
    clear
    echo -e "\e[32m"
    for i in {1..100}; do
        echo -ne "$(cat /dev/urandom 2>/dev/null | tr -dc '01' | fold -w 80 | head -n 1 2>/dev/null)\r"
        sleep 0.05
    done
    clear
}
BASHRC_MATRIX
fi

echo -e "${TOXIC_GREEN}✅ .bashrc generated${NC}"

# ============================================================================
# 6. CONFIGURE TERMUX PROPERTIES
# ============================================================================
echo -e "${FLARE_YELLOW}[!] Configuring termux.properties...${NC}"

mkdir -p "$HOME/.termux"

cat > "$HOME/.termux/termux.properties" << 'TERMUX_PROPS'
# Weaponize - Enhanced Termux Properties

# Extra keys (hacker keyboard layout)
extra-keys = [['ESC','/','-','HOME','UP','END','PGUP'],['TAB','CTRL','ALT','LEFT','DOWN','RIGHT','PGDN']]

# Disable bell
bell-character = ignore

# Dark UI
use-black-ui = true

# Fullscreen mode
fullscreen = true

# Font size
font-size = 14

TERMUX_PROPS

echo -e "${TOXIC_GREEN}✅ termux.properties configured${NC}"

# ============================================================================
# 7. INSTALL FONT (OPTIONAL)
# ============================================================================
if [[ "$INSTALL_FONT" =~ ^[Yy]$ ]]; then
    echo -e "${FLARE_YELLOW}[!] Downloading Hack Nerd Font...${NC}"
    
    mkdir -p "$HOME/.termux"
    
    if command -v curl &> /dev/null; then
        curl -L -o "$HOME/.termux/font.ttf" "https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/Hack/Regular/HackNerdFont-Regular.ttf" 2>/dev/null
        echo -e "${TOXIC_GREEN}✅ Font installed${NC}"
    else
        echo -e "${FLARE_YELLOW}⚠ curl not found. Skipping font download.${NC}"
    fi
fi

# ============================================================================
# 8. RELOAD TERMUX
# ============================================================================
echo -e "${FLARE_YELLOW}[!] Reloading Termux configuration...${NC}"
termux-reload-settings 2>/dev/null || true

# ============================================================================
# 9. SUMMARY
# ============================================================================
echo ""
echo -e "${TOXIC_GREEN}═══════════════════════════════════════════════════════════════${NC}"
echo -e "${TOXIC_GREEN}  ✅ TERMUX WEAPONIZATION COMPLETE${NC}"
echo -e "${TOXIC_GREEN}═══════════════════════════════════════════════════════════════${NC}"
echo ""
echo -e "${CYBER_BLUE}Your new prompt will look like:${NC}"
echo ""
echo -e "${PROMPT_COLOR}┌─[ ${HACKER_NAME}@weaponize ]─[ ~ ]${NC}"
echo -e "${PROMPT_COLOR}└──╼ $ ${NC}"
echo ""
echo -e "${FLARE_YELLOW}⚠ Reopen Termux to see the transformation!${NC}"
echo ""

# Export for install.sh
export HACKER_NAME
export COLOR_CHOICE
export PROMPT_COLOR

echo -e "${TOXIC_GREEN}✅ Returning to Weaponize installer...${NC}"
sleep 1