{ pkgs, lib, ... }:
{
  imports = [
    ./hardware-configuration.nix
  ];

  networking.hostName = "vm";
  system.boot.plymouth = lib.mkForce false;

  suites = {
    desktop = {
      enable = true;
      addons.hyprland.enable = true;
    };
  };

  system.boot.enable = true;
}