{ lib, ... }:
{
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.wireless.enable = lib.mkForce false;
  networking.networkmanager.enable = true;

  suites.common.enable = true;
  services.ssh.enable = true;

  system.stateVersion = "25.05";
}