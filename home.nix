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
    vscode = {
      enable = true;
      package = pkgs.vscode;
      extensions = with pkgs.vscode-extensions; [
        bbenoist.nix
        arrterian.nix-env-selector
        rust-lang.rust-analyzer
        vadimcn.vscode-lldb
        oderwat.indent-rainbow
        eamodio.gitlens
        github.vscode-pull-request-github
        usernamehw.errorlens
        tamasfe.even-better-toml
        serayuzgur.crates
        ms-vscode-remote.remote-ssh
        ms-azuretools.vscode-docker
        golang.go
        yzhang.markdown-all-in-one
        pkief.material-icon-theme
        zxh404.vscode-proto3
      ] ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
        {
          name = "remote-containers";
          publisher = "ms-vscode-remote";
          version = "0.283";
          sha256 = "LaZzDLfQHFaOnkvKzq0vmUvAi+Q6sJrJPlAhWX0fY40=";
        }
        {
          name = "vscode-paste-image";
          publisher = "mushan";
          version = "1.0.4";
          sha256 = "a6prHWZ8neNYJ+ZDE9ZvA79+5X0UlsFf8XSHYfOmd/I=";
        }
        {
          name = "copilot";
          publisher = "github";
          version = "1.77.9225";
          sha256 = "tRAjWiaUIkAULfgWWAKVVz7Zgugw0CQtFIdvf9fhmKs=";
        }
      ];
      userSettings = {
        "editor.inlineSuggest.enabled" = true;
        "editor.formatOnSave" = true;
        "editor.linkedEditing" = true;
        "explorer.confirmDelete" = false;
        "explorer.confirmDragAndDrop" = false;
        "workbench.iconTheme" = "material-icon-theme";
        "workbench.sideBar.location" = "right";
        "markdown.updateLinksOnFileMove.enabled" = "always";

        "protoc" = {
          "options" = [
            "--proto_path=**/proto"
          ];
        };

        "github.copilot.enable" =  {
          "*" = true;
          "yaml" = false;
          "plaintext" = false;
        };

        "rust-analyzer" = {
          "rustfmt.rangeFormatting.enable" = true;
          "runnableEnv" = {
            "CARGO_NET_GIT_FETCH_WITH_CLI" = "true";
          };
          "assist.emitMustUse" = true;
          "cargo.buildScripts.overrideCommand" = null;
          "check.extraArgs" = [ "--release" ];
          "runnables.extraArgs" = [ "--release" ];
        };

        "git.suggestSmartCommit" = false;

        "[rust]" = {
          "editor.defaultFormatter" = "rust-lang.rust-analyzer";
        };
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

    zsh = {
      enable = true;
      history = {
        size = 10000;
        save = 100000;
        expireDuplicatesFirst = true;
        extended = true;
      };
      enableAutosuggestions = true;
      enableSyntaxHighlighting = true;
      oh-my-zsh = {
        enable = true;
        plugins = [
          "git"
          "sudo"
          "cp"
          "docker"
          "docker-compose"
          "rust"
        ];
        theme = "robbyrussell";
      };
  
    };

    chromium = {
      enable = true;
      extensions = [
        {id = "ennpfpdlaclocpomkiablnmbppdnlhoh"; } # rust extension
        {id = "djhndpllfiibmcdbnmaaahkhchcoijce"; } # casper signer
        {id = "nkbihfbeogaeaoehlefnkodbefgpgknn"; } # metamask
        {id = "mopnmbcafieddcagagdcbnhejhlodfdd"; } # polkadot js apps
        {id = "kbfnbcaeplbcioakkpcpgfkobkghlhen"; } # grammarly
        {id = "hdokiejnpimakedhajhdlcegeplioahd"; } # lastpass
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