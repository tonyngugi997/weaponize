#!/bin/bash
set -e

# ============================================================================
# WEAPONIZE INSTALLER - Professional Edition
# ============================================================================
# Clean, minimal, confident. No theatrics. Just results.
# ============================================================================

# Colors (professional palette)
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
WHITE='\033[1;37m'
DIM='\033[2m'
NC='\033[0m'
BOLD='\033[1m'

# Simple status icons
CHECK="${GREEN}✓${NC}"
CROSS="${RED}✗${NC}"
ARROW="${CYAN}→${NC}"

# ============================================================================
# UTILITY FUNCTIONS
# ============================================================================

log_info() {
    echo -e "${ARROW} ${1}"
}

log_success() {
    echo -e "${CHECK} ${1}"
}

log_error() {
    echo -e "${CROSS} ${1}"
}

log_step() {
    echo ""
    echo -e "${BOLD}${CYAN}▶ ${1}${NC}"
    echo -e "${DIM}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
}

spinner() {
    local pid=$1
    local delay=0.1
    local spinstr='⠋⠙⠹⠸⠼⠴⠦⠧⠇⠏'
    while kill -0 "$pid" 2>/dev/null; do
        for i in $(seq 0 9); do
            echo -ne "\r${DIM}${spinstr:$i:1}${NC} Working... "
            sleep $delay
        done
    done
    echo -ne "\r${CHECK} Done.          \n"
}

# ============================================================================
# HEADER (clean, single line)
# ============================================================================
clear
echo -e "${BOLD}${WHITE}Weaponize Installer v2.0${NC} — Neovim IDE for Termux"
echo -e "${DIM}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}\n"

# ============================================================================
# CHECK FOR EXISTING CONFIG
# ============================================================================
if [ -d "$HOME/.config/nvim" ]; then
    log_info "Existing Neovim config found at ~/.config/nvim"
    TIMESTAMP=$(date +"%Y-%m-%d_%H-%M-%S")
    BACKUP_DIR="$HOME/.config/nvim_backup_$TIMESTAMP"
    
    echo -e "  ${YELLOW}→${NC} Backing up to: ${DIM}${BACKUP_DIR}${NC}"
    mv "$HOME/.config/nvim" "$BACKUP_DIR" &
    spinner $!
    log_success "Backup complete"
else
    log_success "No existing config found — clean install"
fi

# ============================================================================
# CREATE DIRECTORIES
# ============================================================================
log_info "Creating configuration directories..."
mkdir -p "$HOME/.config/nvim" &
spinner $!
log_success "Directories ready"

# ============================================================================
# COPY CONFIGURATION FILES
# ============================================================================
log_step "Installing Neovim configuration"

if [ -f "init.lua" ]; then
    cp init.lua "$HOME/.config/nvim/init.lua"
    log_success "init.lua installed"
else
    log_error "init.lua not found in current directory"
    exit 1
fi

# ============================================================================
# OPTIONAL: CUSTOM TERMUX UI
# ============================================================================
echo ""
read -p "$(echo -e "${ARROW} ${CYAN}Install Termux custom UI?${NC} (y/n) [n]: " )" INSTALL_TERMUX_UI

if [[ "$INSTALL_TERMUX_UI" =~ ^[Yy]$ ]]; then
    if [ -f "custom-termux.sh" ]; then
        log_step "Installing Termux UI enhancements"
        source custom-termux.sh
        log_success "Termux UI installed"
    else
        log_error "custom-termux.sh not found — skipping"
    fi
else
    log_info "Skipping Termux UI (you can run custom-termux.sh later)"
fi

# ============================================================================
# INSTALL PLUGINS (LAZY.NVIM)
# ============================================================================
log_step "Installing Neovim plugins"
log_info "First launch will install plugins automatically"

# ============================================================================
# COMPLETE
# ============================================================================
echo ""
echo -e "${GREEN}${BOLD}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${GREEN}${BOLD}✓ Installation complete${NC}"
echo -e "${GREEN}${BOLD}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo ""
echo -e "  ${WHITE}Launch:${NC}  nvim"
echo -e "  ${WHITE}Note:${NC}    First launch takes 30–60 seconds (downloading plugins)"
echo ""
echo -e "${DIM}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"