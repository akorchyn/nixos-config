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
    ];
  };

  programs = {
    home-manager.enable = true;
    
    vscode = import ./programs/vscode.nix pkgs;
    git = import ./programs/git.nix;
    zsh = import ./programs/zsh.nix;
    chromium = import ./programs/chromium.nix;

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