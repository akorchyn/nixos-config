
{ pkgs, ... }:
{
  enable = true;
  package = pkgs.unstable.vscode;
  extensions = with pkgs.vscode-marketplace; [
    bbenoist.nix
    arrterian.nix-env-selector
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
    davidanson.vscode-markdownlint
    rust-lang.rust-analyzer
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
    "rust-analyzer.checkOnSave.command" = "clippy";
    "rust-analyzer.server.path" = "rust-analyzer";

    "git.suggestSmartCommit" = false;
    "[rust]" = {
      "editor.defaultFormatter" = "rust-lang.rust-analyzer";
    };
    "markdownlint.ignore" = [
      "target"
    ];
    "gitlens.currentLine.enabled" = true;
    "gitlens.views.repositories.includeWorkingTree" = true;
    "gitlens.views.stashes.files.compact" = true;
    "gitlens.views.contributors.showAllBranches" = true;
    "tailwindCSS.experimental.classRegex" =  [
      "class: \"(.*)\""
    ];
    "tailwindCSS.includeLanguages" = {
      "rust" = "html";
    };
    "files.insertFinalNewline" = true;
  };
}
