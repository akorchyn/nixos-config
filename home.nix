{ pkgs, ... }:
let
  zed-fhs = pkgs.buildFHSUserEnv {
    name = "zedf";
    targetPkgs = pkgs:
      with pkgs; [
        openssl
        curl
        fontconfig
        freetype
        libgit2
        openssl
        sqlite
        zlib
        zstd
        perl
        systemd
        protobuf
        rustPlatform.bindgenHook
        vulkan-loader

        alsa-lib
        libxkbcommon
        wayland
        xorg.libxcb
        pkg-config
      ];
    extraOutputsToInstall = [ "dev" ];
    runScript = "/home/yurtur/.local/bin/zed";
    profile=''
      export LD_LIBRARY_PATH="$LD_LIBRARY_PATH:${pkgs.vulkan-loader}"
      export PKG_CONFIG_PATH="${pkgs.openssl.dev}/lib/pkgconfig:${pkgs.systemd.dev}/lib/pkgconfig";
    '';

  };
in
{
  nixpkgs.config.allowUnfree = true;
  xsession.preferStatusNotifierItems = true;

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
      pkgs.zsh-powerlevel10k
      pkgs.meslo-lgs-nf
      pkgs.xclip
      pkgs.killall
      pkgs.gnomeExtensions.dash-to-dock
      pkgs.gnomeExtensions.appindicator
      pkgs.dbeaver-bin
      pkgs.docker-compose
      pkgs.ripgrep
      pkgs.brave
      pkgs.insomnia
      pkgs.ledger-live-desktop
      pkgs.gpu-screen-recorder
      pkgs.gpu-screen-recorder-gtk
      pkgs.solaar
      pkgs.libiconv
      pkgs.openssl
      pkgs.pkg-config
      pkgs.rustup
      pkgs.nodejs-18_x
      pkgs.time
      pkgs.protobuf
      pkgs.protoc-gen-rust
      pkgs.protoc-gen-tonic
      pkgs.protoc-gen-prost
      pkgs.systemd
      pkgs.binaryen
      pkgs.jq
      pkgs.wabt
      pkgs.go
      pkgs.gnumake
      pkgs.clang
      pkgs.zulip
      pkgs.nixd
      pkgs.taplo
      zed-fhs

      (pkgs.lib.optionals pkgs.stdenv.isLinux pkgs.mold)
      (pkgs.calibre.override {
        unrarSupport = true;
      })
    ];
    sessionVariables = rec {
      PROTOC="protoc";
      PKG_CONFIG_PATH="${pkgs.openssl.dev}/lib/pkgconfig:${pkgs.systemd.dev}/lib/pkgconfig";
      LD_LIBRARY_PATH = pkgs.lib.strings.makeLibraryPath [
        pkgs.stdenv.cc.cc.lib
        pkgs.llvmPackages.libclang.lib
        pkgs.systemd
      ];
      CARGO_NET_GIT_FETCH_WITH_CLI="true";
      LIBCLANG_PATH = "${pkgs.llvmPackages.libclang.lib}/lib";
      CC_wasm32_unknown_unknown = "${pkgs.llvmPackages.clang-unwrapped}/bin/clang-16";
      CFLAGS_wasm32_unknown_unknown = "-I ${pkgs.llvmPackages.libclang.lib}/lib/clang/16/include/";
      VK_DRIVER_FILES = "/run/opengl-driver/share/vulkan/icd.d/nvidia_icd.x86_64.json";
    };
    sessionPath = [
      "/home/yurtur/.local/bin"
      "/home/yurtur/.cargo/bin"
      "/home/yurtur/.fly/bin"
    ];
  };
  xdg.configFile."nvim".source = ./conf.d/nvim;
  programs = {
    home-manager.enable = true;

    vscode = import ./programs/vscode.nix pkgs;
    git = import ./programs/git.nix;
    direnv = {
      enable = true;
      enableZshIntegration = true;
      nix-direnv.enable = true;
    };

    zoxide = {
      enable = true;
      enableZshIntegration = true;
      options = [
        "--cmd cd"
      ];
    };

    zsh = import ./programs/zsh.nix pkgs;
    chromium = import ./programs/chromium.nix;
    gnome-terminal = import ./programs/gnome-terminal.nix;
    neovim = import ./programs/neovim.nix;

    gpg.enable = true;
    gh.enable = true;
  };

  services = {
    gpg-agent = {
      enable = true;
      pinentryPackage = pkgs.pinentry-gnome3;
      enableSshSupport = true;
    };
  };

  dconf.enable = true;
  dconf.settings = import ./settings/dconf.nix;
}
