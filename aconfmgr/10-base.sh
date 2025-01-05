
AddPackage linux # The Linux kernel and modules
AddPackage linux-firmware # Firmware files for Linux
AddPackage base # Minimal package set to define a basic Arch Linux installation
AddPackage base-devel # Basic tools to build Arch Linux packages
AddPackage amd-ucode # Microcode update image for AMD CPUs
AddPackage efibootmgr # Linux user-space application to modify the EFI Boot Manager
AddPackage lshw # A small tool to provide detailed information on the hardware configuration of the machine.
AddPackage openssh # SSH protocol implementation for remote login, command execution and file transfer
AddPackage networkmanager # Network connection manager and user applications

CreateFile /etc/.pwd.lock 600 > /dev/null
CopyFile /etc/NetworkManager/system-connections/TP-Link_2.4GHz_070FDA.nmconnection 600
CopyFile /etc/adjtime
CopyFile /etc/fstab
CopyFile /etc/group
CopyFile /etc/group-
CopyFile /etc/gshadow
CopyFile /etc/gshadow- 600
CopyFile /etc/hostname
CopyFile /etc/locale.conf
CopyFile /etc/locale.gen
CopyFile /etc/machine-id 444
CopyFile /etc/mkinitcpio.d/linux.preset
CopyFile /etc/modprobe.d/iwlwifi.conf
CopyFile /etc/pacman.conf
CopyFile /etc/pacman.d/mirrorlist
CopyFile /etc/paru.conf
CreateFile /etc/sddm.conf > /dev/null
CopyFile /etc/sddm.conf.d/kde_settings.conf
CopyFile /etc/shells
CopyFile /etc/subgid
CreateFile /etc/subgid- > /dev/null
CopyFile /etc/subuid
CreateFile /etc/subuid- > /dev/null
CopyFile /etc/sudoers
CopyFile /etc/vconsole.conf
CopyFile /etc/xdg/reflector/reflector.conf
CreateDir /lost+found 700
CreateLink /etc/fonts/conf.d/10-hinting-slight.conf /usr/share/fontconfig/conf.default/10-hinting-slight.conf
CreateLink /etc/fonts/conf.d/10-scale-bitmap-fonts.conf /usr/share/fontconfig/conf.default/10-scale-bitmap-fonts.conf
CreateLink /etc/fonts/conf.d/10-sub-pixel-rgb.conf /usr/share/fontconfig/conf.default/10-sub-pixel-rgb.conf
CreateLink /etc/fonts/conf.d/10-yes-antialias.conf /usr/share/fontconfig/conf.default/10-yes-antialias.conf
CreateLink /etc/fonts/conf.d/11-lcdfilter-default.conf /usr/share/fontconfig/conf.default/11-lcdfilter-default.conf
CreateLink /etc/fonts/conf.d/20-unhint-small-vera.conf /usr/share/fontconfig/conf.default/20-unhint-small-vera.conf
CreateLink /etc/fonts/conf.d/30-metric-aliases.conf /usr/share/fontconfig/conf.default/30-metric-aliases.conf
CreateLink /etc/fonts/conf.d/40-nonlatin.conf /usr/share/fontconfig/conf.default/40-nonlatin.conf
CreateLink /etc/fonts/conf.d/45-generic.conf /usr/share/fontconfig/conf.default/45-generic.conf
CreateLink /etc/fonts/conf.d/45-latin.conf /usr/share/fontconfig/conf.default/45-latin.conf
CreateLink /etc/fonts/conf.d/46-noto-mono.conf /usr/share/fontconfig/conf.default/46-noto-mono.conf
CreateLink /etc/fonts/conf.d/46-noto-sans.conf /usr/share/fontconfig/conf.default/46-noto-sans.conf
CreateLink /etc/fonts/conf.d/46-noto-serif.conf /usr/share/fontconfig/conf.default/46-noto-serif.conf
CreateLink /etc/fonts/conf.d/48-spacing.conf /usr/share/fontconfig/conf.default/48-spacing.conf
CreateLink /etc/fonts/conf.d/49-sansserif.conf /usr/share/fontconfig/conf.default/49-sansserif.conf
CreateLink /etc/fonts/conf.d/50-user.conf /usr/share/fontconfig/conf.default/50-user.conf
CreateLink /etc/fonts/conf.d/51-local.conf /usr/share/fontconfig/conf.default/51-local.conf
CreateLink /etc/fonts/conf.d/60-generic.conf /usr/share/fontconfig/conf.default/60-generic.conf
CreateLink /etc/fonts/conf.d/60-latin.conf /usr/share/fontconfig/conf.default/60-latin.conf
CreateLink /etc/fonts/conf.d/65-fonts-persian.conf /usr/share/fontconfig/conf.default/65-fonts-persian.conf
CreateLink /etc/fonts/conf.d/65-nonlatin.conf /usr/share/fontconfig/conf.default/65-nonlatin.conf
CreateLink /etc/fonts/conf.d/66-noto-mono.conf /usr/share/fontconfig/conf.default/66-noto-mono.conf
CreateLink /etc/fonts/conf.d/66-noto-sans.conf /usr/share/fontconfig/conf.default/66-noto-sans.conf
CreateLink /etc/fonts/conf.d/66-noto-serif.conf /usr/share/fontconfig/conf.default/66-noto-serif.conf
CreateLink /etc/fonts/conf.d/69-unifont.conf /usr/share/fontconfig/conf.default/69-unifont.conf
CreateLink /etc/fonts/conf.d/80-delicious.conf /usr/share/fontconfig/conf.default/80-delicious.conf
CreateLink /etc/fonts/conf.d/90-synthetic.conf /usr/share/fontconfig/conf.default/90-synthetic.conf
CreateLink /etc/localtime /usr/share/zoneinfo/Europe/Amsterdam
CreateLink /etc/os-release ../usr/lib/os-release
CreateLink /etc/systemd/user/default.target.wants/xdg-user-dirs-update.service /usr/lib/systemd/user/xdg-user-dirs-update.service
CreateLink /etc/systemd/user/pipewire-session-manager.service /usr/lib/systemd/user/wireplumber.service
CreateLink /etc/systemd/user/pipewire.service.wants/wireplumber.service /usr/lib/systemd/user/wireplumber.service
CreateLink /etc/systemd/user/sockets.target.wants/p11-kit-server.socket /usr/lib/systemd/user/p11-kit-server.socket
CreateLink /etc/systemd/user/sockets.target.wants/pipewire-pulse.socket /usr/lib/systemd/user/pipewire-pulse.socket
CreateLink /etc/systemd/user/sockets.target.wants/pipewire.socket /usr/lib/systemd/user/pipewire.socket
CopyFile /etc/sddm.conf.d/hidpi.conf
