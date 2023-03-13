
{ pkgs, ... }:
{
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
}