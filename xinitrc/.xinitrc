while true
do
    #VOL=$(amixer get Master | tail -1 | sed 's/.*\[\([0-9]*%\)\].*/\1/')
    LOCALTIME=$(date +%d-%m-%y\ %H:%M)
    TEMP="$(($(cat /sys/class/thermal/thermal_zone0/temp) / 1000))C"

    xsetroot -name "  $TEMP | $LOCALTIME "

    sleep 5s
done &

dbus-update-activation-environment --systemd DISPLAY
#eval $(gnome-keyring-daemon --start --components=pkcs11,secrets,ssh,gpg)
#export SSH_AUTH_SOCK GNOME_KEYRING_CONTROL GNOME_KEYRING_PID GPG_AGENT_INFO


sxhkd &
feh --randomize --bg-fill ~/Pictures/* &
picom &
cbatticon -n &
nm-applet &

redshift -l 52.39:4.65&

volnoti &
optimus-manager-qt &
mailspring -b &

rfkill unblock bluetooth

~/.packages/arch_touchpad_setup/arch_touchpad_setup.bash

exec dwm
