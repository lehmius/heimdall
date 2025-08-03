{ pkgs, lib, ... }:
{
  imports = [
    ./hardware-configuration.nix
    ./disks.nix
  ];

  networking.hostName = "framework";

  suites = {
    desktop = {
      enable = true;
      addons = {
        hyprland.enable = true;
      };
    };
  };

  boot = {
    kernelPackages = pkgs.linuxPackages_latest;
    resumeDevice = "dev/disk/by-label/nixos";
  };
}
