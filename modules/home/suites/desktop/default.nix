{ pkgs, config, lib, inputs, ... }:
with lib;
with lib.heimdall;
let
  cfg = config.suites.desktop;
in
{
  options.suites.desktop = {
    enable = mkEnableOption "Enable home desktop suit";
  };

  config = mkIf cfg.enable {
    # Fixes tray icons
    systemd.user.targets.tray = {
      Unit = {
        Description = "Home Manager System Tray";
	Requires = [ "graphical-session-pre.target" ];
      };
    };

    desktop.addons.xdg.enable = true;
    
    home.sessionVariables = {
      MOZ_ENABLE_WAYLAND = 1;
      QT_QPA_PLATFORM = "wayland;xcb";
      NIXOS_OZONE_WL = "1";
    };

    home.packages = with pkgs; [
      brightnessctl
      xdg-utils
      playerctl
      wl-clipboard
    ];

  };
}
