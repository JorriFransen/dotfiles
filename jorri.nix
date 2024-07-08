{ lib, pkgs, pkgs-unstable, nur-no-pkgs, ... }:

{

  nixpkgs.config = {
    allowUnfree = true;
  };

  home.username = "jorri";
  home.homeDirectory = "/home/jorri";

  home.stateVersion = "24.05"; # Please read the comment before changing.

  home.packages = [

    (pkgs.nerdfonts.override { fonts = [ "JetBrainsMono" ]; })

    pkgs.brave
    pkgs.steam-run
    pkgs-unstable.gitkraken
    pkgs.btop
    pkgs.ivpn
    pkgs.ivpn-service
    pkgs.stow
    pkgs.wget
    pkgs.git
    pkgs.kitty
    pkgs.tmux
    pkgs.wl-clipboard

    pkgs.kakoune
    pkgs.kak-lsp

    pkgs.lazygit

    pkgs.fd
    pkgs.fzf
    pkgs.ripgrep
    pkgs.bat
    pkgs.clang-tools
    pkgs.clang
    pkgs.meson
    pkgs.gdb
    pkgs.gnumake
    pkgs.ninja
    pkgs.nil

    pkgs.tree
    pkgs.unzip

    pkgs.zeal
    pkgs.nextcloud-client

    pkgs.feh

    pkgs.virt-manager
    pkgs.virtiofsd

    pkgs.obsidian

    pkgs.mpv
  ];

  programs = {

    zsh = {
      enable = true;
      shellAliases = {
        code = "codium";
        ssh = "kitty +kitten ssh";
      };
      initExtra = lib.fileContents ./zsh/.zshrc;
    };

    password-store = {
      enable = true;
      package = pkgs.pass.withExtensions (exts: [ exts.pass-otp ]);
      settings = {
          PASSWORD_STORE_DIR = "/home/jorri/.password-store";
      };
    };

    neovim = {
      enable = true;
      vimAlias = true;
      extraLuaConfig = lib.fileContents ./nvim/.config/nvim/init.lua;

      extraPackages = [
        pkgs.unzip
        pkgs.fd
        pkgs.fzf
        pkgs.clang-tools
        pkgs.lua-language-server
        pkgs.nil
      ];
    };

    vscode = {
        enable = true;
        package = pkgs.vscodium.fhsWithPackages (ps: with ps; [ gdb ]);
    };

    firefox = {
      enable = true;
      package = (pkgs.firefox.override { nativeMessagingHosts = [ pkgs.passff-host ]; });
      # nativeMessagingHosts = [ pkgs.passff-host ];
      profiles = {
        default = {
          id = 0;
          name = "default";
          isDefault = true;
          settings = {
            "extensions.autoDisableScopes" = 0;
          };
          extensions = with nur-no-pkgs.repos.rycee.firefox-addons; [
            vimium-c
            passff
            darkreader
          ];
        };
      };
    };

    chromium = {
      enable = true;
      package = (pkgs.ungoogled-chromium.override {
        commandLineArgs = [ "--extension-mime-request-handling=always-prompt-for-install" ];
        enableWideVine = true;
      });
      commandLineArgs = [ "--extension-mime-request-handling=always-prompt-for-install" ];
      extensions =
      let
        createSourceExtensionFor = browserVersion: { id, sha256, url, version}:
          {
            inherit id;
            crxPath = builtins.fetchurl {
              name = "${id}.crx";
              inherit url;
              inherit sha256;
            };
            inherit version;
          };
        createChromiumExtensionFor = browserVersion: { id, sha256, version }:
          {
            inherit id;
            crxPath = builtins.fetchurl {
              url = "https://clients2.google.com/service/update2/crx?response=redirect&acceptformat=crx2,crx3&prodversion=${browserVersion}&x=id%3D${id}%26installsource%3Dondemand%26uc";
              name = "${id}.crx";
              inherit sha256;
            };
            inherit version;
          };
        createSourceExtension = createSourceExtensionFor (lib.versions.major pkgs.ungoogled-chromium.version);
        createChromiumExtension = createChromiumExtensionFor (lib.versions.major pkgs.ungoogled-chromium.version);
      in
      [
        # nix-prefetch-url --name arst.crx 'https://clients2.google.com/service/...
        (createSourceExtension {  # Web Store
          url = "https://github.com/NeverDecaf/chromium-web-store/releases/download/v1.5.4.3/Chromium.Web.Store.crx";
          id = "ocaahdebbfolfmndjeplogmgcagdmblk";
          sha256 = "1j3ppn6j0aaqwyj5dyl8hdmjxia66dz1b4xn69h1ybpiz6p1r840";
          version = "1.5.4.3";
        })
        (createChromiumExtension { # ublock origin
          id = "cjpalhdlnbpafiamejdnhcphjbkeiagm";
          sha256 = "01kk94l38qqp2rbyylswjs8q25kcjaqvvh5b8088xria5mbrhskl";
          version = "1.58.0";
        })
        (createChromiumExtension { # vimium-c
          id = "hfjbmagddngcpeloejdejnfgbamkjaeg";
          sha256 = "1rd810ra5a15qv9fvpp99lbjdv6d909nrn45m1572xhx5dwqg4r3";
          version = "1.99.99";
        })
        (createChromiumExtension { # dark reader
          id = "eimadpbcbfnmbkopoojfekhnkhdbieeh";
          sha256 = "14dxg1pf7y0ka5rfpwzl6nr4y5hnxwy0cdn3498ffkz1mcs6jmay";
          version = "4.9.87";
        })
        (createChromiumExtension { # chrome-pass
          id = "oblajhnjmknenodebpekmkliopipoolo";
          sha256 = "0wlhkrn19af4kgbm7vv9acqfjmgfd1986ilk3q0x71smr0b95anx";
          version = "0.5.1";
        })
      ];
    };

  };

  services = {
    nextcloud-client = {
      enable = false;
      startInBackground = false;
    };
  };

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
      ".config/zsh/antigen.zsh".source = ./zsh/.config/zsh/antigen.zsh;

    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/jorri/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    # EDITOR = "emacs";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
