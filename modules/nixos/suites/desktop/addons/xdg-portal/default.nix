{ config, lib, pkgs, ... }:
with lib;
with lib.heimdall;
let
  cfg = config.suites.desktop.addons.xdg-portal;
in {
  options.suites.desktop.addons.xdg-portal = {
    enable = mkEnableOption "Whether or not to add support for xdg portal.";
  };

  config = mkIf cfg.enable {
    xdg.portal = {
      enable = true;
      extraPortals = with pkgs; [
        xdg-desktop-portal-gtk
        xdg-desktop-portal-hyprland
      ];
    };
  };
}