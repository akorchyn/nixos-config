{
  description = "NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-22.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager/release-22.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    nix-vscode-extensions.url = "github:nix-community/nix-vscode-extensions";
  };  

  outputs = inputs@{ self, nixpkgs, home-manager, nix-vscode-extensions, nixpkgs-unstable, ... }:
    let
      user = "yurtur";
      system = "x86_64-linux";
      overlay-unstable = final: prev: {
        unstable = import nixpkgs-unstable {
          inherit system;
          config.allowUnfree = true;
        };
      };
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true; 
        overlays = [
          (self: super: {
            discord = super.discord.overrideAttrs (
              _: { src = builtins.fetchTarball {
                url = "https://discord.com/api/download?platform=linux&format=tar.gz";
                sha256 = "12yrhlbigpy44rl3icir3jj2p5fqq2ywgbp5v3m1hxxmbawsm6wi";
              }; }
            );
          })
          nix-vscode-extensions.overlays.default
          overlay-unstable
        ];
      };
      lib = nixpkgs.lib;
    in {
      nixosConfigurations = {
        nixos = lib.nixosSystem {
          inherit system;
          modules = [ 
            ./configuration.nix
            home-manager.nixosModules.home-manager {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages  = true;
              home-manager.users.yurtur = import ./home.nix pkgs;
            }
          ];
        };
      };
    };
}