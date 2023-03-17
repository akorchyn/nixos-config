
{ pkgs, ... }:
{
  enable = true;
  package = pkgs.vscode;
  extensions = with pkgs.vscode-marketplace; [
    bbenoist.nix
    arrterian.nix-env-selector
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
    ms-vscode-remote.remote-containers
    mushan.vscode-paste-image
    rust-lang.rust-analyzer
    github.copilot-labs
  ] ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
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
    "terminal.integrated.fontFamily" = "MesloLGS NF";
    "terminal.integrated.profiles.linux" = {
      "zsh" = {
        "path" = "/run/current-system/sw/bin/zsh";
        "icon" = "terminal";
      };
      "bash" = {
        "path" = "/run/current-system/sw/bin/bash";
        "args" = [ "-l" ];
        "icon" = "terminal-bash";
      };
    };
    "terminal.integrated.defaultProfile.linux" = "zsh";
    
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

    "rust-analyzer.rustfmt.rangeFormatting.enable" = true;
    "rust-analyzer.runnableEnv" = {
      "CARGO_NET_GIT_FETCH_WITH_CLI" = "true";
    };
    "rust-analyzer.assist.emitMustUse" = true;
    "rust-analyzer.cargo.buildScripts.overrideCommand" = null;
    "rust-analyzer.check.extraArgs" = [ "--release" ];
    "rust-analyzer.runnables.extraArgs" = [ "--release" ];
    "rust-analyzer.checkOnSave.extraArgs" = [ "--release" ];

    "git.suggestSmartCommit" = false;
    "[rust]" = {
      "editor.defaultFormatter" = "rust-lang.rust-analyzer";
    };
  };
}