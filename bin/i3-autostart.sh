#!/usr/bin/env zsh

AUTOSTART_LOG="/tmp/autostart.log"

COMPTON_CONFIG="${HOME}/.config/compton/compton.conf"

function run_log_cmd () {
  local cmd
  cmd="${1}"
  echo -e "$(tput setaf 12)[$(date +'%H:%M:%S')] RUNNING: ${cmd}$(tput sgr0)"
  eval "${cmd}"
}

gnome-keyring-daemon -d
setxkbmap -option ctrl:nocaps
compton --config ~/.config/compton/compton.conf -b
/usr/lib/xfce4/notifyd/xfce4-notifyd
xss-lock -- i3lock
mate-power-manager
redshift-gtk
nitrogen --restore
udiskie
nm-applet
blueman-applet
clipit
pasystray

# BAR?
