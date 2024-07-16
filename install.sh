#!/bin/bash

wallpaper=$HOME/.config/hypr/wallpaper_effects/.wallpaper_modified
waybar_style="$HOME/.config/waybar/style/[Wallust] Box type.css"
waybar_config="$HOME/.config/waybar/configs/[TOP] Default_v3"
waybar_config_laptop="$HOME/.config/waybar/configs/[TOP] Default Laptop_v3"

# Check if running as root. If root, script will exit
if [ $EUID -eq 0 ]; then
  echo "This script should not be executed as root!"
  echo "Exiting..."
  exit 1
fi

source ./Global.sh

# Create directory for install logs
if [ ! -d $LOG_DIR ]; then
  mkdir $LOG_DIR
fi
LOG="$LOG_DIR/install-$(date +d-%H%M%S)_dotfiles.log"

# Update home folder
xdg-user-dirs-update 2>&1 | tee -a $LOG || true

# Uncomment WLR_NO_HARDWARE_CURSORS if Nvidia is detected
if lspci -k | grep -A 2 -E "(VGA|3D)" | grep -iq nvidia; then
  print_with_log $NOTE "Nvidia GPU detected. Setting up proper env variables."
  sed -i "/env = LIBVA_DRIVER_NAME,nvidia/s/^#//" config/hypr/UserConfigs/ENVaribles.conf
  sed -i "/env = __GLX_VENDOR_LIBRARY_NAME,nvidia/s/^#//" config/hypr/UserConfigs/ENVaribles.conf
  sed -i "/env = NVD_BACKEND,direct/s/^#//" config/hypr/UserConfigs/ENVaribles.conf
fi

# Uncomment WLR_RENDERER_ALLOW_SOFTWARE, 1 if running in a VM is detected
if hostnamectl | grep -q "Chassis: vm"; then
  print_with_log $NOTE "System is running in a virtual machine."
  sed -i "s/^\([[:space:]]*no_hardware_cursors[[:space:]]*=[[:space:]]*\)false/\1true/" config/hypr/UserConfigs/UserSettings.conf
  sed -i "/env = WLR_RENDERER_ALLOW_SOFTWARE,1/s/^#//" config/hypr/UserConfigs/ENVaribles.conf
  sed -i "/monitor = Virtual-1, 1920x1080@60,auto,1/s/^#//" config/hypr/UserConfigs/Monitors.conf
fi

# Check if dpkg is installed (use to check if Debian/Ubuntu/Based distros)
if command -v dpkg &> /dev/null; then
  print_with_log $NOTE "Debian/Ubuntu based distro detected. Disabling pyprland."
  sed -i "/^exec-once = pypr &/ s/^/#/" config/hypr/UserConfigs/Startup_Apps.conf
fi

# Function to detect keyboard layout
detect_keyboard_layout() {
  if command -v localectl >/dev/null 2>&1; then
    layout=$(localectl status --no-pager | awk "/X11 Layout/ {print $3}")
    if [ -n layout ]; then
      echo $layout
    fi
  elif command -v setxkbmap >/dev/null 2>&1; then
    layout=$(setxkbmap -query | grep layout | awk "{print $2}")
    if [ -n layout ]; then
      echo $layout
    fi
  fi
}

# Function to enter keyboard layout
enter_keyboard_layout() {
  while true; do
    print $RED "
    █▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀█
            STOP AND READ
    █▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄█

      !!! IMPORTANT WARNING !!!

    The default keyboard layout could not be detected.
    You need to set it MANUALLY.

          !!! WARNING !!!

    Setting a wrong Keyboard Layout will cause Hyprland to crash.
    If you are not sure, just type us

    NOTE:
    - You can also set more than 2 keyboard layouts
    - For example: us,kr,gb,ru
    "
    read -p "$ACTION Please enter the correct keyboard layout: " layout
    if [ -n $layout ]; then
      echo $layout
      break
    else
      print $ERROR "Please enter a keyboard layout."
    fi
  done
}

# Function for confirm keyboard layout
confirm_keyboard_layout() {
  # Update the 'kb_layout =' line with the desired layout in the file
  awk -v layout=$1 '/kb_layout/ {$0 = "  kb_layout = " layout} 1' config/hypr/UserConfigs/UserSettings.conf > temp.conf
  mv temp.conf config/hypr/UserConfigs/UserSettings.conf
  print_with_log $NOTE "kb_layout $1 configured in settings."
}

# Detect the current keyboard layout
keyboard_layout=$(detect_keyboard_layout)
if [ $keyboard_layout = "(unset)" ]; then
  keyboard_layout=$(enter_keyboard_layout)
fi
while true; do
  read -p "$ORANGE Current keyboard layout is: $keyboard_layout. Is it correct? (y/n) " confirm
  case $confirm in
    [yY])
      confirm_keyboard_layout $keyboard_layout
      break ;;
    [nN])
      new_keyboard_layout=$(enter_keyboard_layout)
      confirm_keyboard_layout $new_keyboard_layout
      break ;;
    *)
      print $ERROR "Please enter either 'y' or 'n'."
      ;;
  esac
done

# Ask whether to change to 12hr format
while true; do
  print $ORANGE "By default, configs are in 24H format."
  read -p "$ACTION Do you want to change to 12H format (AM/PM)? (y/n) " confirm

  case $confirm in
    [yY])
      # Waybar config
      # Clock 1
      sed -i 's#^    \/\/"format": " {:%I:%M %p}", // AM PM format#    "format": " {:%I:%M %p}", // AM PM format#' config/waybar/modules 2>&1 | tee -a "$LOG"
      sed -i 's#^    "format": " {:%H:%M:%S}", // 24H#    \/\/"format": " {:%H:%M:%S}", // 24H#' config/waybar/modules 2>&1 | tee -a "$LOG"
      # Clock 2
      sed -i 's#^    "format": "  {:%H:%M}", // 24H#    \/\/"format": "  {:%H:%M}", // 24H#' config/waybar/modules 2>&1 | tee -a "$LOG"
      # Clock 3
      sed -i 's#^    \/\/"format": "{:%I:%M %p - %d/%b}", //for AM/PM#    "format": "{:%I:%M %p - %d/%b}", //for AM/PM#' config/waybar/modules 2>&1 | tee -a "$LOG"
      sed -i 's#^    "format": "{:%H:%M - %d/%b}", // 24H#    \/\/"format": "{:%H:%M - %d/%b}", // 24H#' config/waybar/modules 2>&1 | tee -a "$LOG"
      # Clock 4
      sed -i 's#^    \/\/"format": "{:%B | %a %d, %Y | %I:%M %p}", // AM PM format#    "format": "{:%B | %a %d, %Y | %I:%M %p}", // AM PM format#' config/waybar/modules 2>&1 | tee -a "$LOG"
      sed -i 's#^    "format": "{:%B | %a %d, %Y | %H:%M}", // 24H#    \/\/"format": "{:%B | %a %d, %Y | %H:%M}", // 24H#' config/waybar/modules 2>&1 | tee -a "$LOG"
      # Clock 5
      sed -i 's#^    \/\/"format": "{:%A, %I:%M %P}", // AM PM format#    "format": "{:%A, %I:%M %P}", // AM PM format#' config/waybar/modules 2>&1 | tee -a "$LOG"
      sed -i 's#^    "format": "{:%a %d | %H:%M}", // 24H#    \/\/"format": "{:%a %d | %H:%M}", // 24H#' config/waybar/modules 2>&1 | tee -a "$LOG"

      # Hyprlock config
      sed -i 's/^    text = cmd\[update:1000\] echo -e "\$(date +"%H")"/# &/' config/hypr/hyprlock.conf 2>&1 | tee -a "$LOG"
      sed -i 's/^# *text = cmd\[update:1000\] echo -e "\$(date +"%I")" #AM\/PM/    text = cmd\[update:1000\] echo -e "\$(date +"%I")" #AM\/PM/' config/hypr/hyprlock.conf 2>&1 | tee -a "$LOG"
      sed -i 's/^    text = cmd\[update:1000\] echo -e "\$(date +"%S")"/# &/' config/hypr/hyprlock.conf 2>&1 | tee -a "$LOG"
      sed -i 's/^# *text = cmd\[update:1000\] echo -e "\$(date +"%S %p")" #AM\/PM/    text = cmd\[update:1000\] echo -e "\$(date +"%S %p")" #AM\/PM/' config/hypr/hyprlock.conf 2>&1 | tee -a "$LOG"

      # SDDM
      # simple-sddm
      sddm_folder="/usr/share/sddm/themes/simple-sddm"
      if [ -d "$sddm_folder" ]; then
        print_with_log $NOTE "Simple sddm exists. Editing to 12H format"

        sudo sed -i 's|^## HourFormat="hh:mm AP"|HourFormat="hh:mm AP"|' "$sddm_folder/theme.conf" 2>&1 | tee -a "$LOG" || true
        sudo sed -i 's|^HourFormat="HH:mm"|## HourFormat="HH:mm"|' "$sddm_folder/theme.conf" 2>&1 | tee -a "$LOG" || true

        print_with_log $OK "12H format set to SDDM theme successfully."
      fi
      # simple-sddm-2
      sddm_folder_2="/usr/share/sddm/themes/simple-sddm-2"
      if [ -d "$sddm_folder_2" ]; then
        print_with_log $NOTE "Simple sddm 2 exists. Editing to 12H format"

        sudo sed -i 's|^## HourFormat="hh:mm AP"|HourFormat="hh:mm AP"|' "$sddm_folder_2/theme.conf" 2>&1 | tee -a "$LOG" || true
        sudo sed -i 's|^HourFormat="HH:mm"|## HourFormat="HH:mm"|' "$sddm_folder_2/theme.conf" 2>&1 | tee -a "$LOG" || true

        print_with_log $OK "12H format set to SDDM theme successfully."
      fi

      break ;;
    [nN])
      print_with_log $OK "Keep using 24H format."
      break ;;
    *)
      print $ERROR "Please enter either 'y' or 'n'."
      ;;
  esac
done

# Rofi appearance
print $ORANGE "Select monitor resolution for better Rofi appearance:"
print $YELLOW "  1. Equal or less than 1080p (≤ 1080)"
print $YELLOW "  2. Equal or greater than 1440p (≥ 1440p)"
while true; do
  read -p "$ACTION Enter the number of your choice: " choice
  case $choice in
    1)
      resolution="1080p"
      break;;
    2)
      resolution="1440p"
      break;;
    *)
      print $ERROR "Invalid choice.";;
  esac
done
cp -r config/rofi/resolution/"$resolution"/* config/rofi

# Rainbow borders
print $NOTE "By default, Rainbow Borders animation is enabled."
print $NOTE "However, this uses a bit more CPU and Memory resources."
read -p "Do you want to disable Rainbow Borders animation? (y/n) " confirm
if [ $choice =~ ^[Yy]$ ]; then
  # Move RainbowBorders.sh to backup location
  mv config/hypr/UserScripts/RainbowBorders.sh config/hypr/UserScripts/RainbowBorders.bak.sh
  # Comment out the line exec-once = $UserScripts/RainbowBorders.sh &
  sed -i '/exec-once = \$UserScripts\/RainbowBorders.sh \&/s/^/#/' config/hypr/UserConfigs/Startup_Apps.conf
  # Comment out the line animation = borderangle, 1, 180, liner, loop
  sed -i '/  animation = borderangle, 1, 180, liner, loop/s/^/#/' config/hypr/UserConfigs/UserSettings.conf
  print_with_log $OK "Rainbow Borders is disabled."
else
  print_with_log $OK "No changes made. Rainbow Borders remain enabled."
fi

# Copy config files
set -e # Exit immediately if a command exits with a non-zero status

dots=(
  ags
  alacritty
  btop
  cava
  fastfetch
  hypr
  kitty
  Kvantum
  nvim
  qt5ct
  qt6ct
  rofi
  swappy
  swaync
  wallust
  waybar
  wlogout
)
for DIR in ${dots[@]}; do
  DIRPATH=~/.config/"$DIR"
  if [ -d $DIRPATH ]; then
    print_with_log $NOTE "Config for $DIR found. Attempting to backup."
    BACKUP_DIR="backup_$(date +%m%d_%H%M%S)"
    mv $DIRPATH $BACKUP_DIR 2>&1 | tee -a $LOG
    print_with_log $NOTE "Backed up $DIR to $BACKUP_DIR"
  fi
done

# Copy config files
mkdir -p ~/.config
cp -r configs/* ~/.config/ && {
  print $OK "Copy config files completed"
} || {
  print $ERROR "Failed to copy config files."
  exit 1
} 2>&1 || tee -a $LOG

# # Copy Wallpapers
# mkdir -p ~/Pictures/wallpapers
# cp -r wallpapers ~/Pictures/ && {
#   print $OK "Copy wallpapers completed"
# } || {
#   print $ERROR "Failed to copy wallpapers."
#   exit 1
# } 2>&1 | tee -a $LOG

# Set some files as executable
chmod +x ~/.config/hypr/scripts/* 2>&1 | tee -a $LOG
chmod +x ~/.config/hypr/UserScripts/* 2>&1 | tee -a $LOG
chmod +x ~/.config/hypr/initial-boot.sh 2>&1 | tee -a $LOG

# Detect machine type and set Waybar configurations accordingly
if hostnamectl | grep -q 'Chassis: desktop'; then
    # configurations for a desktop
    ln -sf "$waybar_config" "$HOME/.config/waybar/config" 2>&1 | tee -a "$LOG"
    rm -r "$HOME/.config/waybar/configs/[TOP] Default Laptop" "$HOME/.config/waybar/configs/[BOT] Default Laptop" 2>&1 | tee -a "$LOG"
    rm -r "$HOME/.config/waybar/configs/[TOP] Default Laptop_v2" "$HOME/.config/waybar/configs/[TOP] Default Laptop_v3" 2>&1 | tee -a "$LOG"
else
    # configurations for a laptop or any system other than desktop
    ln -sf "$waybar_config_laptop" "$HOME/.config/waybar/config" 2>&1 | tee -a "$LOG"
    rm -r "$HOME/.config/waybar/configs/[TOP] Default" "$HOME/.config/waybar/configs/[BOT] Default" 2>&1 | tee -a "$LOG"
    rm -r "$HOME/.config/waybar/configs/[TOP] Default_v2" "$HOME/.config/waybar/configs/[TOP] Default_v3" 2>&1 | tee -a "$LOG"
fi

# # symlinks for waybar style
# ln -sf "$waybar_style" "$HOME/.config/waybar/style.css" && \
# # initialize wallust to avoid config error on hyprland
# wallust run -s $wallpaper 2>&1 | tee -a "$LOG"

print $OK "Copy Completed!"
print $WARN "ATTENTION!!!!"
print $WARN "YOU NEED to logout and re-login or reboot to avoid issues"

