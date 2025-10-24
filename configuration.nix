# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, inputs, ... }:
{

  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./modules/nix-ld.nix
    ];

  # Bootloader.

  boot = {
    loader = {
      # grub = {
      #   enable = true;
      #   devices = ["nodev"];
      #   useOSProber = true;
      #   configurationLimit = 15;
      #   efiSupport = true;
      # };
      systemd-boot = {
        enable = true;
        configurationLimit = 15;
      };
      efi = {
        canTouchEfiVariables = true;
        efiSysMountPoint = "/boot/efi";
      };
    };
    supportedFilesystems = [ "ntfs" ];
    kernelPackages = pkgs.linuxPackages_latest;
    kernelParams = ["nvidia-drm.fbdev=1" "nvidia-drm.modeset=1" "nvidia.NVreg_PreserveVideoMemoryAllocations=1"];
  };

  # Windows time sync
  time.hardwareClockInLocalTime = true;

  # Setup keyfile
  boot.initrd.secrets = {
    "/crypto_keyfile.bin" = null;
  };

  networking.hostName = "nixos"; # Define your hostname.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Kyiv";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "uk_UA.UTF-8";
    LC_IDENTIFICATION = "uk_UA.UTF-8";
    LC_MEASUREMENT = "uk_UA.UTF-8";
    LC_MONETARY = "uk_UA.UTF-8";
    LC_NAME = "uk_UA.UTF-8";
    LC_NUMERIC = "uk_UA.UTF-8";
    LC_PAPER = "uk_UA.UTF-8";
    LC_TELEPHONE = "uk_UA.UTF-8";
    LC_TIME = "uk_UA.UTF-8";
  };

  
  services.dbus.packages = [ pkgs.gcr ];
  # Enable the GNOME Desktop Environment.

  # Configure keymap in X11
  services.xserver = {
    enable = true;
    xkb.layout = "us,ua,ru";
    xkb.variant = "";
    xkb.options = "grp:win_space_toggle";
    exportConfiguration = true;
  };
  services.desktopManager.gnome.enable = true;
  services.udisks2.enable = true;
  services.displayManager.sddm = {
		enable = true;			
    theme = "${import ./modules/sddm-theme.nix pkgs}";
  };
  services.blueman.enable = true;

  xdg.portal.enable = true;
  programs.hyprland = {
    package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
    portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
    enable = true;
  };

  environment.gnome.excludePackages = (with pkgs; [
    gnome-photos
    gnome-tour
    cheese # webcam tool
    gnome-music
    gnome-terminal    
    gedit # text editor
    epiphany # web browser
    geary # email reader
    evince # document viewer 
    gnome-characters
    totem # video player
    tali # poker game
    iagno # go game
    hitori # sudoku game
    atomix # puzzle game
  ]);

  # Enable CUPS to print documents.
  services.printing.enable = true;

  services.pulseaudio.enable = false;
  hardware.logitech.wireless.enable = true;
  hardware.ledger.enable = true;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.yurtur = {
    isNormalUser = true;
    description = "Artur-Yurii Korchynskyi";
    extraGroups = [ "networkmanager" "wheel" "docker" "plugdev" ];
    packages = with pkgs; [];
    shell = pkgs.zsh;
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.firefox.nativeMessagingHosts.packages = with pkgs; [
    gnome-browser-connector
  ];
  services.gnome.gnome-browser-connector.enable = true;
  fonts.packages = with pkgs; [
      font-awesome
      noto-fonts
      powerline-fonts
      powerline-symbols
      nerd-fonts.symbols-only
    ];

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    vim
    wget
    firefox
    nix-index
    gnomeExtensions.appindicator
    libsForQt5.qt5.qtquickcontrols2   
    libsForQt5.qt5.qtgraphicaleffects
    swaynotificationcenter
    kitty
    rofi
    swww
    networkmanagerapplet
    waybar
    libnotify
    wlogout
    nixfmt-rfc-style
  ];
  environment.pathsToLink = [ "/share/zsh" ];
  services.udev.packages = with pkgs; [ gnome-settings-daemon ledger-udev-rules ];

  virtualisation.docker.enable = true;

  programs.zsh.enable = true;

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "22.11"; # Did you read the comment?

  nix = {
    settings.auto-optimise-store = true;
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
    package = pkgs.nixVersions.latest;
    extraOptions = "experimental-features = nix-command flakes";
  };

  nix.settings.trusted-users = [ "root" "yurtur" ];

  nix.settings = {
    substituters = ["https://hyprland.cachix.org" "https://nix-community.cachix.org"];
    trusted-public-keys = ["hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc=" "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="];
  };
}
