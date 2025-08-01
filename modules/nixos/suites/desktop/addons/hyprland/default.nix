{ config, lib, ... }:
with lib;
with lib.heimdall;
let
  cfg = config.suites.desktop.addons.hyprland;
in {
  options.suites.desktop.addons.hyprland = {
    enable = mkEnableOption "Enable or disable the hyprland window manager.";
  };

  config = mkIf cfg.enable {
    environment.sessionVariables.NIXOS_OZONE_WL = "1";
    programs.hyprland = {
      enable = true;
      xwayland.enable = true;
    };

    suites.desktop.addons.greetd.enable = true;
    suites.desktop.addons.xdg-portal.enable = true;
  };
}