{ inputs, lib, config, pkgs, pkgs-unstable, system, ... }:

{

  nixpkgs.config.allowUnfree = true;

  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "jorri";
  home.homeDirectory = "/home/jorri";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.05"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = [
    # # Adds the 'hello' command to your environment. It prints a friendly
    # # "Hello, world!" when run.
    # pkgs.hello

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')

    (pkgs.nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
    pkgs.brave
    pkgs.steam-run
    pkgs.fd
    pkgs.fzf
    pkgs-unstable.gitkraken
    pkgs.htop
    pkgs.btop
    pkgs.ivpn
    pkgs.ivpn-service
    pkgs.kitty
    pkgs.stow
    pkgs.tmux
    pkgs.wget
    pkgs.wl-clipboard

    pkgs.kakoune
    pkgs.kak-lsp

    pkgs.lazygit

    pkgs.clang-tools
    pkgs.clang
    pkgs.meson
    pkgs.gdb
    pkgs.cmake
    pkgs.ninja
    pkgs.nil

    pkgs.tree
    pkgs.unzip

    pkgs.nix-search-cli
  ];

  programs = {

    zsh = {
      enable = true;
      shellAliases = {
        code = "codium";
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
