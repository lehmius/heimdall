{ pkgs, lib, ... }:
{
  imports = [
    ./hardware-configuration.nix
    ./disks.nix
  ];

  networking.hostName = "vm";
  system.boot.plymouth = lib.mkForce false;

  suites = {
    desktop = {
      enable = true;
      addons.hyprland.enable = true;
    };
  };

  boot = {
    supportedFilesystems = lib.mkForce ["btrfs"];
    kernelPackages = pkgs.linuxPackages_latest;
    resumeDevice = "/dev/disk/by-label/nixos";
  };
  
  system.stateVersion = "25.05";
}
