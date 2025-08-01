{ config, lib, pkgs, ... }:
with lib;
with lib.heimdall;
let
  cfg = config.desktops.addons.hyprlock;
in
{
  options.desktops.addons.hyprlock = {
    enable = mkEnableOption "Enable hyprlock";
  };

  config = mkIf cfg.enable {
    programs.hyprlock = {
      enable = true;
      settings = {
      };
    };
  };
}
