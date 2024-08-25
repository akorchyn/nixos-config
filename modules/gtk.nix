{ pkgs, ... }:

let 
    gruvboxPlus = import ./gtk/gruvbox-plus.nix { inherit pkgs; };
    css = builtins.readFile ./gtk/gtk.css; 
in
{
    enable = true;

    gtk3.extraCss = css;
    gtk4.extraCss = css;

    cursorTheme.package = pkgs.bibata-cursors;
    cursorTheme.name = "Bibata-Modern-Ice";

    theme.package = pkgs.adw-gtk3;
    theme.name = "adw-gtk3";

    iconTheme.package = gruvboxPlus;
    iconTheme.name = "Gruvbox-Plus-Dark";
}
