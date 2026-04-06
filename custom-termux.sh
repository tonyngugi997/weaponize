#!/bin/bash
# ============================================================================
# WEAPONIZE - TERMUX DEEP IMMERSION UI
# ============================================================================
# This script creates a beautiful, multi‑colored, hacker‑style terminal.
# It uses the user's chosen handle, accent color, and optional enhancements.
# ============================================================================

# Colors for the installer's own messages
BLOOD_RED='\e[38;2;255;0;30m'
TOXIC_GREEN='\e[38;2;0;255;100m'
CYBER_BLUE='\e[38;2;0;200;255m'
FLARE_YELLOW='\e[38;2;255;200;0m'
DARK_GREY='\e[38;2;80;80;90m'
PURPLE='\e[38;2;180;80;255m'
ORANGE='\e[38;2;255;128;0m'
NC='\e[0m'
BOLD='\e[1m'

echo ""

# ============================================================================
# 1. BACKUP EXISTING CONFIGS
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
# 2. HACKER HANDLE (this will appear in the prompt)
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
# 3. ACCENT COLOR (used for prompt symbols and highlights)
# ============================================================================
echo ""
echo -e "${CYBER_BLUE}┌─────────────────────────────────────────────────────────────────┐${NC}"
echo -e "${CYBER_BLUE}│${NC} ${FLARE_YELLOW}🎨 SELECT YOUR ACCENT COLOR${NC}"
echo -e "${CYBER_BLUE}├─────────────────────────────────────────────────────────────────┤${NC}"
echo -e "${CYBER_BLUE}│${NC}   ${BLOOD_RED}1. BLOOD RED     - Aggressive${NC}"
echo -e "${CYBER_BLUE}│${NC}   ${TOXIC_GREEN}2. TOXIC GREEN   - Matrix classic${NC}"
echo -e "${CYBER_BLUE}│${NC}   ${CYBER_BLUE}3. CYBER BLUE    - Neon cyberpunk${NC}"
echo -e "${CYBER_BLUE}│${NC}   ${PURPLE}4. PURPLE HAZE   - Synthwave${NC}"
echo -e "${CYBER_BLUE}│${NC}   ${ORANGE}5. NUCLEAR AMBER - Old school${NC}"
echo -e "${CYBER_BLUE}├─────────────────────────────────────────────────────────────────┤${NC}"
echo -ne "${CYBER_BLUE}│${NC} ${TOXIC_GREEN}Enter choice (1-5): ${NC}"
read COLOR_CHOICE

case $COLOR_CHOICE in
    1) ACCENT="$BLOOD_RED" ;;
    2) ACCENT="$TOXIC_GREEN" ;;
    3) ACCENT="$CYBER_BLUE" ;;
    4) ACCENT="$PURPLE" ;;
    5) ACCENT="$ORANGE" ;;
    *) ACCENT="$TOXIC_GREEN" ;;
esac
echo -e "${CYBER_BLUE}└─────────────────────────────────────────────────────────────────┘${NC}"

# ============================================================================
# 4. OPTIONAL FEATURES
# ============================================================================
echo ""
echo -e "${CYBER_BLUE}┌─────────────────────────────────────────────────────────────────┐${NC}"
echo -e "${CYBER_BLUE}│${NC} ${FLARE_YELLOW}🔧 ENHANCEMENTS${NC}"
echo -e "${CYBER_BLUE}├─────────────────────────────────────────────────────────────────┤${NC}"
read -p "$(echo -e "${CYBER_BLUE}│${NC} Install Hack Nerd Font (icons)? ${TOXIC_GREEN}(Y/n)${NC}: ")" INSTALL_FONT
read -p "$(echo -e "${CYBER_BLUE}│${NC} Show boot animation on start? ${TOXIC_GREEN}(Y/n)${NC}: ")" BOOT_ANIM
read -p "$(echo -e "${CYBER_BLUE}│${NC} Enable transparent background? ${TOXIC_GREEN}(y/N)${NC}: ")" TRANSPARENT
echo -e "${CYBER_BLUE}└─────────────────────────────────────────────────────────────────┘${NC}"

# ============================================================================
# 5. INSTALL FONT (if yes)
# ============================================================================
if [[ "$INSTALL_FONT" =~ ^[Yy]$ ]] || [[ -z "$INSTALL_FONT" ]]; then
    echo ""
    echo -e "${FLARE_YELLOW}[!] Installing Hack Nerd Font...${NC}"
    mkdir -p "$HOME/.termux"
    if command -v curl &> /dev/null; then
        curl -L -o "$HOME/.termux/font.ttf" \
            "https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/Hack/Regular/HackNerdFont-Regular.ttf" 2>/dev/null
        echo -e "${TOXIC_GREEN}✅ Font installed${NC}"
    else
        echo -e "${FLARE_YELLOW}⚠ curl missing, skipping font${NC}"
    fi
fi

# ============================================================================
# 6. TERMUX COLOR SCHEME (background, foreground, cursor)
# ============================================================================
echo ""
echo -e "${FLARE_YELLOW}[!] Setting Termux color scheme...${NC}"
mkdir -p "$HOME/.termux"

# Extract RGB values from the accent color (e.g., \e[38;2;0;255;100m -> 0;255;100)
# We'll use a simple mapping for the cursor color to match the accent
case $COLOR_CHOICE in
    1) CURSOR_RGB="255;0;30" ;;
    2) CURSOR_RGB="0;255;100" ;;
    3) CURSOR_RGB="0;200;255" ;;
    4) CURSOR_RGB="180;80;255" ;;
    5) CURSOR_RGB="255;128;0" ;;
    *) CURSOR_RGB="0;255;100" ;;
esac

cat > "$HOME/.termux/colors.properties" << EOF
# Weaponize Deep UI Color Scheme
background=#0a0a0f
foreground=#e0e0e0
cursor=#${CURSOR_RGB//;/;}#  (this is handled by termux)
EOF
# Actually termux expects RGB like 255,0,30 for cursor. Let's use a simpler method:
cat > "$HOME/.termux/colors.properties" << EOF
background=#0a0a0f
foreground=#e0e0e0
cursor=#$(printf "%02x%02x%02x" ${CURSOR_RGB//;/ })
EOF

echo -e "${TOXIC_GREEN}✅ Terminal colors set (dark background, soft text, matching cursor)${NC}"

# ============================================================================
# 7. TERMUX UI CONFIG (extra keys, transparency, etc.)
# ============================================================================
echo -e "${FLARE_YELLOW}[!] Configuring Termux UI...${NC}"

# Base properties
cat > "$HOME/.termux/termux.properties" << 'EOF'
# Weaponize - Termux UI Configuration
bell-character = ignore
use-black-ui = true
fullscreen = true
font-size = 14
cursor-style = block
cursor-blink-rate = 500
extra-keys = [ \
  ['ESC','/','-','HOME','UP','END','PGUP'], \
  ['TAB','CTRL','ALT','LEFT','DOWN','RIGHT','PGDN'], \
  ['{','}','(',')','[',']','<','>'], \
  ['⚡','🔫','💀','🗡️','💣','🐉','🔥'] \
]
EOF

if [[ "$TRANSPARENT" =~ ^[Yy]$ ]]; then
    echo "background_opacity = 0.85" >> "$HOME/.termux/termux.properties"
    echo -e "${TOXIC_GREEN}✅ Transparency enabled (85%)${NC}"
fi

echo -e "${TOXIC_GREEN}✅ UI configured (extra weapon keys added)${NC}"

# ============================================================================
# 8. BUILD THE .BASHRC WITH DEEP IMMERSION PROMPT
# ============================================================================
echo -e "${FLARE_YELLOW}[!] Generating immersive .bashrc...${NC}"

cat > "$HOME/.bashrc" << 'EOF'
# ============================================================================
# WEAPONIZE DEEP IMMERSION BASHRC
# ============================================================================

# Color definitions (ANSI 24‑bit)
export NC='\e[0m'
export BOLD='\e[1m'
export DIM='\e[2m'
export WHITE='\e[38;2;255;255;255m'
export GREY='\e[38;2;150;150;150m'
export CYAN='\e[38;2;0;200;255m'
EOF

# Inject the user's accent color
cat >> "$HOME/.bashrc" << EOF
export ACCENT='${ACCENT}'
EOF

# Git branch function
cat >> "$HOME/.bashrc" << 'EOF'
git_branch() {
    git branch 2>/dev/null | grep '*' | sed 's/* //'
}
EOF

# Build the multi‑color prompt
cat >> "$HOME/.bashrc" << EOF
# Deep immersion prompt
PROMPT_COMMAND='__update_ps1() {
    local branch=\$(git_branch)
    local branch_part=""
    if [ -n "\$branch" ]; then
        branch_part=" \${GREY}─[ \${ACCENT}\${branch}\${GREY} ]"
    fi
    PS1="\n\${GREY}┌─[ \${ACCENT}${HACKER_NAME}\${GREY}@\${ACCENT}weaponize\${GREY} ]─[ \${CYAN}\w\${GREY} ]\${branch_part}\n\${GREY}└──╼ \${ACCENT}\\\$ \${NC}"
}; __update_ps1'
EOF

# Aliases
cat >> "$HOME/.bashrc" << 'EOF'
alias ll='ls -la --color=auto'
alias la='ls -a --color=auto'
alias l='ls --color=auto'
alias cls='clear'
alias ..='cd ..'
alias ...='cd ../..'
alias weaponize='nvim'
alias hack='nvim'
alias matrix='bash ~/.matrix.sh 2>/dev/null || echo "Matrix effect coming soon"'
EOF

# Boot animation (only once)
if [[ "$BOOT_ANIM" =~ ^[Yy]$ ]] || [[ -z "$BOOT_ANIM" ]]; then
    cat >> "$HOME/.bashrc" << 'EOF'
if [ -z "$WEAPONIZE_BOOTED" ]; then
    export WEAPONIZE_BOOTED=1
    clear
    echo -e "\e[38;2;0;255;100m"
    cat << "BOOT"
┌─────────────────────────────────────────────────────────────────┐
│  ⚡ WEAPONIZE TERMINAL v2.0                                     │
│  "Your Android is now a weapon."                               │
└─────────────────────────────────────────────────────────────────┘
BOOT
    echo -e "\e[0m"
    echo -e "\e[38;2;0;255;100mWeaponizing system... ████████████████████ 100%\e[0m"
    echo -e "\e[38;2;255;200;0mLast login: $(date)\e[0m"
    echo "───────────────────────────────────────────────────────────────────"
    echo ""
fi
EOF
fi

echo -e "${TOXIC_GREEN}✅ .bashrc generated with immersive prompt${NC}"

# ============================================================================
# 9. OPTIONAL MATRIX SCREENSAVER
# ============================================================================
if [[ "$MATRIX_SAVER" =~ ^[Yy]$ ]]; then
    echo -e "${FLARE_YELLOW}[!] Creating Matrix screensaver...${NC}"
    cat > "$HOME/.matrix.sh" << 'EOF'
#!/bin/bash
clear
echo -e "\e[32m"
while true; do
    for i in {1..50}; do
        echo -ne "$(cat /dev/urandom 2>/dev/null | tr -dc '01' | fold -w 80 | head -n 1 2>/dev/null)\r"
        sleep 0.05
    done
    sleep 0.5
done
EOF
    chmod +x "$HOME/.matrix.sh"
    echo -e "${TOXIC_GREEN}✅ Matrix screensaver installed (type 'matrix')${NC}"
fi

# ============================================================================
# 10. RELOAD AND SHOW SUMMARY
# ============================================================================
echo -e "${FLARE_YELLOW}[!] Reloading Termux configuration...${NC}"
termux-reload-settings 2>/dev/null || true

echo ""
echo -e "${TOXIC_GREEN}═══════════════════════════════════════════════════════════════${NC}"
echo -e "${TOXIC_GREEN}  ✅ TERMUX DEEP IMMERSION COMPLETE${NC}"
echo -e "${TOXIC_GREEN}═══════════════════════════════════════════════════════════════${NC}"
echo ""
echo -e "${CYBER_BLUE}Your new prompt will look like this:${NC}"
echo ""
echo -e "${GREY}┌─[ ${ACCENT}${HACKER_NAME}${GREY}@${ACCENT}weaponize${GREY} ]─[ ${CYAN}~${GREY} ]${NC}"
echo -e "${GREY}└──╼ ${ACCENT}$ ${NC}"
echo ""
echo -e "${FLARE_YELLOW}✓ Hacker handle '${HACKER_NAME}' is now in your prompt${NC}"
echo -e "${FLARE_YELLOW}✓ Accent color applied only to brackets and symbols (not all text)${NC}"
echo -e "${FLARE_YELLOW}✓ Git branch appears automatically when in a repo${NC}"
echo -e "${FLARE_YELLOW}✓ Extra keys include weapon symbols${NC}"
echo -e "${FLARE_YELLOW}✓ Dark background with soft foreground for easy reading${NC}"
echo ""
echo -e "${FLARE_YELLOW}⚠ REOPEN TERMUX to see the full transformation!${NC}"
echo ""

export HACKER_NAME
export ACCENT
echo -e "${TOXIC_GREEN}✅ Returning to Weaponize installer...${NC}"
sleep 1