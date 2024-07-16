# Copy nvim configs
rm -rf ./config/nvim
yes | cp -rf ~/.config/nvim ./config

# Copy alacritty configs
rm -rf ./config/alacritty
yes | cp -rf ~/.config/alacritty ./config
