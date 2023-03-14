{ pkgs, ... }:
{
  nixpkgs.config.allowUnfree = true;

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
    ];
  };

  programs = {
    home-manager.enable = true;
    
    vscode = import ./programs/vscode.nix pkgs;
    git = import ./programs/git.nix;
    zsh = import ./programs/zsh.nix pkgs;
    chromium = import ./programs/chromium.nix;
    gnome-terminal = import ./programs/gnome-terminal.nix;

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
}