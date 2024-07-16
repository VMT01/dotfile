#!/bin/bash

# Set some constants for install process
LOG_DIR=logs

# Set some colours for output messages
OK="$(tput setaf 2)[OK]"
ERROR="$(tput setaf 1)[ERROR]"
NOTE="$(tput setaf 3)[NOTE]"
WARN="$(tput setaf 166)[WARN]"
ACTION="$(tput setaf 6)[ACTION]"
ORANGE=$(tput setaf 166)
YELLOW=$(tput setaf 3)
RESET=$(tput sgr0)

# Function to colorize prompts
print() {
  printf "$1 $2$RESET\n"
}

print_with_log() {
  printf "$1 $2$RESET\n" 2>&1 | tee -a $LOG
}

# # Function to ask a yes/no question and set the response in a variable
# ask_yes_no() {
#   while true; do read -p "$(print $ACTION "$1 (y/n): ")" choice
#     case $choice in
#       [Yy]* ) eval $2='Y'; return 0;;
#       [Nn]* ) eval $2='N'; return 1;;
#       * ) print $ERROR "Please answer with 'y' or 'n' only.";;
#     esac
#   done
# }

# # Function to execute a script if it exists and make it executable
# exec_script() {
#   local script=$1
#   local script_path=$SCRIPTS_DIR/$script

#   if [ -f $script_path ]; then
#     chmod +x $script_path
#     if [ -x $script_path ]; then
#       print $ACTION "Running $script..."
#       $script_path
#     else
#       print $ERROR "Failed to make script $script executable."
#     fi
#   else
#     print $ERROR "Script $script not found in $SCRIPTS_DIR."
#   fi

#   printf "\n-------------------------------------------------------\n\n"
# }

# # Function for install package
# install_pkg() {
#   # Check if package is already installed
#   if $ISAUR -Q $1 &>> /dev/null; then
#     print_with_log $OK "$1 is already installed." $LOG
#   else
#     print_with_log $ACTION "Installing $1..." $LOG
#     $ISAUR -S --noconfirm $1 2>&1 | tee -a $LOG

#     # Make sure package is installed
#     if $ISAUR -Q $1 &>> /dev/null; then
#       print_with_log $OK "$1 instaled successfully" $LOG
#     else
#       print $ERROR "$1 failed to install. Please check the $LOG"
#       exit 1
#     fi
#   fi
# }
