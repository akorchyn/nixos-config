{
  description = "NixOS configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    nix-vscode-extensions.url = "github:nix-community/nix-vscode-extensions";
    hyprland.url = "git+https://github.com/hyprwm/Hyprland?submodules=1";
    hyprland.inputs.nixpkgs.follows = "nixpkgs";
    lanzaboote = {
      url = "github:nix-community/lanzaboote/v0.4.3"; # https://github.com/nix-community/lanzaboote/releases

      # Optional but recommended to limit the size of your system closure.
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # qt5 has been flagged as unmaintained and insecure, so we must explicitly
    # permit its usage to run Stremio. However, since insecure packages are not
    # built by Hydra once marked with known vulnerabilities, we use a pinned,
    # older nixpkgs revision from before that change. This ensures Hydra can
    # provide prebuilt binaries, since building qt5 locally is too heavy.
    nixpkgs-for-stremio.url = "nixpkgs/5135c59491985879812717f4c9fea69604e7f26f";
  };  

  outputs = inputs@{ self, nixpkgs, home-manager, nix-vscode-extensions, hyprland, lanzaboote, ... }:
    let
      user = "yurtur";
      system = "x86_64-linux";
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
        ];
      };
      lib = nixpkgs.lib;
    in {
      nixosConfigurations = {
        nixos = lib.nixosSystem {
          inherit system;
          specialArgs = { inherit inputs; };
          modules = [
            ./configuration.nix
            home-manager.nixosModules.home-manager {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages  = true;
	            home-manager.backupFileExtension = "backup";
              home-manager.extraSpecialArgs = { inherit inputs; };
              home-manager.users.yurtur = import ./home.nix;
            }
            # Apply overlays to nixpkgs for home-manager
            {
              nixpkgs.overlays = [
                (self: super: {
                  discord = super.discord.overrideAttrs (
                    _: { src = builtins.fetchTarball {
                      url = "https://discord.com/api/download?platform=linux&format=tar.gz";
                      sha256 = "12yrhlbigpy44rl3icir3jj2p5fqq2ywgbp5v3m1hxxmbawsm6wi";
                    }; }
                  );
                })
                nix-vscode-extensions.overlays.default
              ];
            }
            lanzaboote.nixosModules.lanzaboote
            ({ pkgs, lib, ... }: {
  
              environment.systemPackages = [
                # For debugging and troubleshooting Secure Boot.
                pkgs.sbctl
              ];
  
              # Lanzaboote currently replaces the systemd-boot module.
              # This setting is usually set to true in configuration.nix
              # generated at installation time. So we force it to false
              # for now.
              boot.loader.systemd-boot.enable = lib.mkForce false;
  
              boot.lanzaboote = {
                enable = true;
                pkiBundle = "/var/lib/sbctl";
              };
            })
          ];
        };
      };
    };
}
