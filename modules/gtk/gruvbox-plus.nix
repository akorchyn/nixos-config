{ pkgs }:

pkgs.stdenv.mkDerivation {
    name = "gruvbox-plus";

    src = pkgs.fetchurl {
        url = "https://github.com/SylEleuth/gruvbox-plus-icon-pack/releases/download/v5.5.0/gruvbox-plus-icon-pack-5.5.0.zip";
        sha256 = "sha256-0R584wmN342Z4gXK5GOao4hR+jwOhSSLndgUx2zOMmE=";
    };

    nativeBuildInputs = [ pkgs.gtk3 ];

    dontUnpack = true;

    installPhase = ''
        mkdir -p $out/share/icons
        ${pkgs.unzip}/bin/unzip $src -d $out/share/icons/
    '';

    postFixup = ''
        for theme in $out/share/icons/*; do
            gtk-update-icon-cache $theme
        done
    '';
}
