#!/bin/bash
set -e

CYAN='\033[0;36m'
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[0;33m'
NC='\033[0m'
BLUE='\033[0;34m'

# Spinner anim
spinner() {
    local pid=$1
    local delay=0.1
    local spinstr='⠋⠙⠹⠸⠼⠴⠦⠧⠇⠏'
    
    while ps -p "$pid" > /dev/null 2>&1; do
        local temp=${spinstr#?}
        printf " [%c]  " "$spinstr"
        local spinstr=$temp${spinstr%"$temp"}
        sleep $delay
        printf "\b\b\b\b\b\b"
    done
    printf "    \b\b\b\b"
}

# Progress bar
show_progress() {
    local duration=$1
    local steps=20
    local progress=0
    
    printf " ["
    while [ $progress -le $steps ]; do
        printf "="
        progress=$((progress + 1))
        sleep 0.05
    done
    printf "]"
    sleep 0.2
}


typewriter() {
    local text="$1"
    local delay=${2:-0.03}
    local len=${#text}
    local i=0
    
    while [ $i -lt $len ]; do
        char="${text:$i:1}"
        
        # Check if this is the escape character (ASCII 27)
        if [ "$char" = $'\033' ]; then
            # Find where the escape sequence ends (at 'm')
            j=$i
            while [ $j -lt $len ] && [ "${text:$j:1}" != 'm' ]; do
                j=$((j + 1))
            done
            j=$((j + 1))  # Include the 'm'
            
            # Print entire escape sequence instantly
            printf "${text:$i:$((j - i))}"
            i=$j
        else
            # Print normal character with delay
            printf "%s" "$char"
            sleep $delay
            i=$((i + 1))
        fi
    done
    echo ""
}
# Success flash
success_flash() {
    local message="$1"
    
    printf "\r${GREEN}✅ ${message}${NC}"
    sleep 0.1
    printf "\r${NC}   ${message}${NC}"
    sleep 0.1
    printf "\r${GREEN}✅ ${message}${NC}"
    echo ""
}

echo  ""
echo -e "${CYAN}═══════════════════════════════════════════════════════════${NC}"
typewriter "${CYAN} WEAPONIZE INSTALLER${NC}" 0.05
echo -e "${CYAN}═══════════════════════════════════════════════════════════${NC}" 
echo ""

# Backup old nvim config
typewriter "🔍 Initializing weapon systems..." 0.05

printf "${CYAN}checking for old nvim config... ${NC}"

if [ -d "$HOME/.config/nvim" ]; then
    echo ""
    typewriter "${BLUE}📦 Found old configs. Securing them in time capsule...${NC}" 0.03
    
    TIMESTAMP=$(date +"%Y-%m-%d_%H-%M-%S")
    
    # Animated backup
    mv "$HOME/.config/nvim" "$HOME/.config/nvim_backup_$TIMESTAMP" &
    spinner $!
    
    success_flash "Backup complete. Old configs moved to $HOME/.config/nvim_backup_$TIMESTAMP"
else
    echo ""
    typewriter "${YELLOW}✨ No old configs found. Fresh install detected.${NC}" 0.03
fi

echo ""

# Create config dir
printf "${CYAN}📁 Preparing config directory...${NC}"
mkdir -p "$HOME/.config/nvim" &
spinner $!
echo ""
success_flash "Config directory ready at $HOME/.config/nvim"

echo ""

# Copy config files
typewriter "⚙️  Installing Weaponize configs..." 0.05

printf "${CYAN}📦 Copying config files...${NC}"
echo ""

printf "   "
show_progress 1

cp init.lua "$HOME/.config/nvim/init.lua" &
spinner $!

echo ""
success_flash "weaponize config  installed successfully"

echo ""

# Final success message
typewriter "🔥 Finalizing weaponization..." 0.05
sleep 0.5

echo ""
echo -e "${BLUE}═══════════════════════════════════════════════════════════${NC}"
typewriter "${GREEN}✅ WEAPONIZE INSTALLED SUCCESSFULLY${NC}" 0.02
echo -e "${BLUE}═══════════════════════════════════════════════════════════${NC}"
echo ""

typewriter "🚀 Type ${GREEN}nvim${NC} to start coding" 0.05
echo ""

typewriter "${YELLOW}📖 First launch will take 30-60 seconds${NC}" 0.03
typewriter "   (Plugins are installing for the first time)" 0.03
typewriter "   This only happens once. Be patient." 0.03
echo ""

typewriter "${GREEN}🔥 You are now weaponized. Go build something insane.${NC}" 0.05
echo ""