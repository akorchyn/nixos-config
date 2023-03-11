{ pkgs, ... }:
{
  nixpkgs.config.allowUnfree = true;

  home = {
    username = "yurtur";
    homeDirectory = "/home/yurtur";
    stateVersion = "22.11";
    packages = [
      pkgs.slack
      pkgs.tdesktop
      pkgs.microsoft-edge
      pkgs.vscode
      pkgs.discord
      pkgs.pinentry-curses
    ];
  };

  programs = {
    home-manager.enable = true;
    vscode = {
      enable = true;
      package = pkgs.vscode;
      extensions = with pkgs.vscode-extensions; [
        bbenoist.nix
        arrterian.nix-env-selector
        rust-lang.rust-analyzer
        oderwat.indent-rainbow
        eamodio.gitlens
        github.vscode-pull-request-github
        github.copilot
        usernamehw.errorlens
        tamasfe.even-better-toml
        serayuzgur.crates
        ms-vscode-remote.remote-ssh
        ms-azuretools.vscode-docker
      ];
      userSettings = {
        "workbench.sideBar.location" = "right";
      };
    };

    git = {
      enable = true;
      userName = "akorchyn";
      userEmail = "artur.yurii.korchynskyi@gmail.com";
      signing = {
        key = "artur.yurii.korchynskyi@gmail.com";
        signByDefault = true;
      };
      extraConfig = {
        url = {
          "git@github.com:" = {
            insteadOf = "https://github.com/";
          };
        };
      };
      includes = [
        {
          condition = "gitdir:/mnt/work/boosty/**";
          contents = {
            user = {
              email = "artur.korchynskyi@boostylabs.com";
              signingKey = "3E5A592823DBAE21";
            };
          };
        }
        {
          condition = "gitdir:/mnt/work/ggx/**";
          contents = {
            user = {
              email = "artur.yurii.korchynskyi@ggxchain.io";
              signingKey = "93C0473D4D2C654E";
            };
          };
        }
      ];
    };

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