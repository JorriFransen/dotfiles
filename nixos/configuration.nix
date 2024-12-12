
{ config, pkgs, ... }:

let
  lock-false = {
      Value = false;
      Status = "locked";
  };
  lock-true = {
      Value = true;
      Status = "locked";
  };

in

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  nix = {
    package = pkgs.nixVersions.stable;
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };

  hardware.cpu.amd.updateMicrocode = true;

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos"; # Define your hostname.
  networking.networkmanager.enable = true;
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # networking.firewall.enable = false;
  networking.firewall = {
    # for samba discovery
    allowedTCPPorts = [ 445 137 138 139 34445 ];
    allowedUDPPorts = [ 137 138 139 ];

    # Wireguard home tunnel
    logReversePathDrops = true;



    # First line is for smb, rest if for wg home tunnel
    extraCommands = ''
        iptables -t raw -A OUTPUT -p udp -m udp --dport 137 -j CT --helper netbios-ns
        ip46tables -t mangle -I nixos-fw-rpfilter -p udp -m udp --sport 45611 -j RETURN
        ip46tables -t mangle -I nixos-fw-rpfilter -p udp -m udp --dport 45611 -j RETURN
    '';

    # wireguard tunnel
    extraStopCommands = ''
     ip46tables -t mangle -D nixos-fw-rpfilter -p udp -m udp --sport 45611 -j RETURN || true
     ip46tables -t mangle -D nixos-fw-rpfilter -p udp -m udp --dport 45611 -j RETURN || true
   '';
  };

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  time.timeZone = "Europe/Amsterdam";

  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "nl_NL.UTF-8";
    LC_IDENTIFICATION = "nl_NL.UTF-8";
    LC_MEASUREMENT = "nl_NL.UTF-8";
    LC_MONETARY = "nl_NL.UTF-8";
    LC_NAME = "nl_NL.UTF-8";
    LC_NUMERIC = "nl_NL.UTF-8";
    LC_PAPER = "nl_NL.UTF-8";
    LC_TELEPHONE = "nl_NL.UTF-8";
    LC_TIME = "nl_NL.UTF-8";
  };


  hardware = {
    graphics.enable = true;
    graphics.enable32Bit = true;
    nvidia = {
      modesetting.enable = true;
      powerManagement.enable = true;
      # powerManagement.finegrained = true;
      open = false;
      nvidiaSettings = true;
      # package = config.boot.kernelPackages.nvidiaPackages.production;
      prime = {
        amdgpuBusId = "PCI:6:0:0";
        nvidiaBusId = "PCI:1:0:0";
        # offload = {
        #   enable = true;
        #   enableOffloadCmd = true;
        # };
        sync.enable = true;
        # reverseSync.enable = true;
        # allowExternalGpu = true;
      };
    };
  };
  services.xserver.videoDrivers = [ "nvidia" ];

  services.xserver.enable = true;
  services.displayManager.sddm.enable = true;
  services.displayManager.sddm.wayland.enable = true;
  # services.displayManager.sddm.settings = {
  #     General.GreeterEnvironment = "QT_SCREEN_SCALE_FACTORS=1,QT_FONT_DPI=92";
  # };
  services.displayManager.defaultSession = "plasma";
  services.desktopManager.plasma6.enable = true;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Enable CUPS to print documents.
  services.printing =  {
    enable = true;
    drivers = [ pkgs.hplipWithPlugin ];
  };

  services.pcscd.enable = true;
  services.udev.packages = [ pkgs.yubikey-personalization ];


  # Enable sound with pipewire.
  hardware.pulseaudio = {
    enable = false;
    package = pkgs.pulseaudioFull;
  };
  security.rtkit.enable = true;

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;
  hardware.bluetooth.settings = {
    General.Enable = "Source,Sink,Media,Socket";
    General.Experimental = true;
  };

  environment.plasma6.excludePackages = with pkgs.kdePackages; [
    konsole
    oxygen
    plasma-browser-integration
  ];

  environment.systemPackages = with pkgs; [
    zsh
    pinentry-qt

    killall
    git
    nix-search-cli
    htop

    tmux
    (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })

    cifs-utils
    samba
    kdePackages.kdenetwork-filesharing

    hplip

    yubico-pam
    yubikey-manager
    yubikey-manager-qt
    yubikey-agent
    yubikey-personalization
    yubikey-personalization-gui
    yubico-piv-tool
    yubikey-touch-detector
    yubioath-flutter

    pam_u2f
    cfssl
    pcsctools
  ];

  programs.zsh.enable = true;
  users.defaultUserShell = pkgs.zsh;

  programs.firefox = {
    enable = true;
    # package = (pkgs.firefox.override { nativeMessagingHosts = [ pkgs.passff-host ]; });
    nativeMessagingHosts.packages = [
      pkgs.passff-host
    ];
    policies = {
      DisableTelemetry = true;
      DisableFirefoxStudies = true;
      EnableTrackingProtection = {
          Value = true;
          Locked = true;
          Cryptomining = true;
          Fingerprinting = true;
      };
      DisablePocket = true;
      DisableFirefoxAccounts = true;
      DisableAccounts = true;
      DisableFirefoxScreenshots = true;
      OverrideFirstRunPage = "";
      OverridePostUpdatePage = "";
      DontCheckDefaultBrowser = true;

      Preferences = {
        "browser.contentblocking.category" = { Value = "strict"; Status = "locked"; };
        "extensions.pocket.enabled" = lock-false;
        "extensions.screenshots.disabled" = lock-true;
        "browser.topsites.contile.enabled" = lock-false;
        "browser.formfill.enable" = lock-false;
        "browser.search.suggest.enabled" = lock-false;
        "browser.search.suggest.enabled.private" = lock-false;
        "browser.urlbar.suggest.searches" = lock-false;
        "browser.urlbar.showSearchSuggestionsFirst" = lock-false;
        "browser.newtabpage.activity-stream.feeds.section.topstories" = lock-false;
        "browser.newtabpage.activity-stream.feeds.snippets" = lock-false;
        "browser.newtabpage.activity-stream.section.highlights.includePocket" = lock-false;
        "browser.newtabpage.activity-stream.section.highlights.includeBookmarks" = lock-false;
        "browser.newtabpage.activity-stream.section.highlights.includeDownloads" = lock-false;
        "browser.newtabpage.activity-stream.section.highlights.includeVisited" = lock-false;
        "browser.newtabpage.activity-stream.showSponsored" = lock-false;
        "browser.newtabpage.activity-stream.system.showSponsored" = lock-false;
        "browser.newtabpage.activity-stream.showSponsoredTopSites" = lock-false;
      };
    };
  };

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
  };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.jorri = {
    isNormalUser = true;
    description = "Jorri Fransen";
    extraGroups = [ "networkmanager" "wheel" "video" "libvirt" "libvirtd"];
  };

  users.users.work= {
    isNormalUser = true;
    description = "Work account";
    extraGroups = [ "networkmanager" "wheel" "libvirt" "libvirtd"];
  };

  virtualisation.libvirtd.enable = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?

}
