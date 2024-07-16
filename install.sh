dots=(
  alacritty
  nvim
)

for DIR in ${dots[@]}; do
  DIRPATH=~/.config/"$DIR"
  if [ -d $DIRPATH ]; then
    echo -e "Config for $DIR found, attempting to backup"
    BACKUP_DIR="backup-$(date +%m%d_%H%M%S)_$DIR"
    mv $DIRPATH $BACKUP_DIR
    echo "Backup $DIR to $BACKUP_DIR done"
  fi
done

mkdir -p ~/.config
cp -r config/* ~/.config/

# echo "-> Install dependencies for Nvim clipboard..."
# yes | sudo apt-get install xclip

# echo "\n-> Install dependencies for Nvim telescope..."
# yes | sudo apt-get install ripgrep fd-find
# cargo install viu

# echo "\n-> Install dependencies for Nvim lspconfig..."
# yes | sudo apt-get install libssl-dev

# echo "\n-> Install dependencies for Nvim LazyGit..."
# LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')
# curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
# tar xf lazygit.tar.gz lazygit
# yes | sudo install lazygit /usr/local/bin
# rm -rf lazygit.tar.gz lazygit

