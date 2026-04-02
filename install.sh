#!/bin/bash
set -e

# backup old nvim config
printf "checking for old nvim config... "

if [ -d "$HOME/.config/nvim" ]; then
    echo "found old configs. Backing them up....."
    
    TIMESTAMP=$(date +"%Y-%m-%d_%H-%M-%S")
    
    # Move the old config to a backup location
    mv "$HOME/.config/nvim" "$HOME/.config/nvim_backup_$TIMESTAMP"
    
    echo "✅ backup complete. Old configs moved to $HOME/.config/nvim_backup_$TIMESTAMP"
else
    echo "no old configs found. Proceeding with clean installation..."
fi

# create nvim config directory if it doesn't exist
mkdir -p "$HOME/.config/nvim"
echo "✅ config directory ready at $HOME/.config/nvim"

