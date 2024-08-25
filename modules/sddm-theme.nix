{ pkgs, ... }:

let
  # Image by wirestock on Freepik https://www.freepik.com/free-photo/curvy-narrow-muddy-road-dark-forest-surrounded-by-greenery-little-light-coming-from_7810521.htm#fromView=search&page=1&position=6&uuid=f0972b4f-2c6a-475a-a684-c8aa02659a17"
  image = ./sddm/bg.jpg;
in
pkgs.stdenv.mkDerivation {
  name = "sddm-theme";
  src = pkgs.fetchFromGitHub {
    owner = "MarianArlt";
    repo = "sddm-sugar-dark";
    rev = "ceb2c455663429be03ba62d9f898c571650ef7fe";
    sha256 = "0153z1kylbhc9d12nxy9vpn0spxgrhgy36wy37pk6ysq7akaqlvy";
  };
  installPhase = ''
    mkdir -p $out
    cp -R ./* $out/
    cp -rf ${image} $out/Background.jpg
   '';
}
