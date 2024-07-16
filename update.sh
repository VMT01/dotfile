# Copy nvim configs
rm -rf ./config/nvim
mkdir -p ./config/nvim
yes | cp -rf ~/.config/nvim/* ./config/nvim

# Copy alacritty configs
rm -rf ./config/alacritty
mkdir -p ./config/alacritty
yes | cp -rf ~/.config/alacritty/* ./config/alacritty
