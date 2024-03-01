{ pkgs, ... }:
{
  nixpkgs.config.allowUnfree = true;
  xsession.preferStatusNotifierItems = true;

  home = {
    username = "yurtur";
    homeDirectory = "/home/yurtur";
    keyboard = null;
    stateVersion = "22.11";
    packages = [
      pkgs.slack
      pkgs.tdesktop
      pkgs.discord
      pkgs.pinentry-curses
      pkgs.zsh-powerlevel10k
      pkgs.meslo-lgs-nf
      pkgs.xclip
      pkgs.killall
      pkgs.gnomeExtensions.dash-to-dock
      pkgs.gnomeExtensions.appindicator
      pkgs.dbeaver
      pkgs.docker-compose
      pkgs.nodejs-18_x
      pkgs.gcc
      pkgs.ripgrep
      pkgs.brave
    ];
  };
  xdg.configFile."nvim".source = ./conf.d/nvim;
  programs = {
    home-manager.enable = true;
    
    vscode = import ./programs/vscode.nix pkgs;
    git = import ./programs/git.nix;
    direnv = {
      enable = true;
      enableZshIntegration = true; 
      nix-direnv.enable = true;
    };

    zoxide = {
      enable = true;
      enableZshIntegration = true;
      options = [
        "--cmd cd"
      ];
    };

    zsh = import ./programs/zsh.nix pkgs;
    chromium = import ./programs/chromium.nix;
    gnome-terminal = import ./programs/gnome-terminal.nix;
    neovim = import ./programs/neovim.nix;

    gpg.enable = true;
    gh.enable = true;
  };

  services = {
    gpg-agent = {
      enable = true;
      pinentryFlavor = "gnome3";
      enableSshSupport = true;
    };
  };

  dconf.settings = import ./settings/dconf.nix;
}
