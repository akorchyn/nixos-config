# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
{ config, lib, pkgs, modulesPath, ... }:
{
  imports =
    [ (modulesPath + "/installer/scan/not-detected.nix")
    ];

  boot.initrd.availableKernelModules = [ "vmd" "xhci_pci" "ahci" "nvme" "usbhid" "usb_storage" "sd_mod" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [ ];
  boot.initrd.luks.devices."luks-98e53245-477e-4ab1-85ef-34fe0124a315".keyFile = "/crypto_keyfile.bin";
  
  fileSystems."/" =
    { device = "/dev/disk/by-uuid/a5cf7cc3-e57e-49dc-bef3-9bd52623376f";
      fsType = "ext4";
    };

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/8935df21-2ddb-448c-b77c-31a55e222b27";
      fsType = "ext4";
    };

  fileSystems."/boot/efi" =
    { device = "/dev/disk/by-uuid/7A69-0A08";
      fsType = "vfat";
    };

  fileSystems."/home" =
    { device = "/dev/disk/by-uuid/3d381be1-5bb4-4090-9521-1ed0cf63aa25";
      fsType = "ext4";
    };

  fileSystems."/mnt/work" =
    { device = "/dev/disk/by-uuid/bcf94b00-6a23-450c-957f-0ebca5025f26";
      fsType = "ext4";
    };

  boot.initrd.luks.devices."luks-98e53245-477e-4ab1-85ef-34fe0124a315".device = "/dev/disk/by-uuid/98e53245-477e-4ab1-85ef-34fe0124a315";

  swapDevices = [ ];

  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.enp5s0.useDHCP = lib.mkDefault true;
  # networking.interfaces.wlo1.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  powerManagement.cpuFreqGovernor = lib.mkDefault "powersave";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;

  hardware.nvidia.package = config.boot.kernelPackages.nvidiaPackages.stable;
  hardware.opengl.enable = true;
  services.xserver.videoDrivers = [ "nvidia" ];
}