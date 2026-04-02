#!/bin/bash
set -e

CYAN='\033[0;36m'
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[0;33m'
NC='\033[0m' # No Color
BLUE='\033[0;34m'


# backup old nvim config
printf "${CYAN}checking for old nvim config... ${NC}"

if [ -d "$HOME/.config/nvim" ]; then
    echo "${BLUE}found old configs. Backing them up.....${NC}"
    
    TIMESTAMP=$(date +"%Y-%m-%d_%H-%M-%S")
    
    # Move the old config to a backup location
    mv "$HOME/.config/nvim" "$HOME/.config/nvim_backup_$TIMESTAMP"
    
    echo "${GREEN}✅ backup complete. Old configs moved to $HOME/.config/nvim_backup_$TIMESTAMP${NC}"
else
    echo "${YELLOW}no old configs found. Proceeding with clean installation...${NC}                                         ${NC}                           "
fi

# create nvim config directory if it doesn't exist
mkdir -p "$HOME/.config/nvim"
echo "${GREEN}✅ config directory ready at $HOME/.config/nvim${NC}"

# copy new config files
echo " "
echo "${CYAN}copying new config files...${NC}"
cp init.lua "$HOME/.config/nvim/init.lua"

echo "${GREEN}✅ new config files copied successfully.${NC}"
echo "${BLUE}weaponize config installed at:${NC}"
echo "${GREEN}$HOME/.config/nvim/init.lua${NC}"

