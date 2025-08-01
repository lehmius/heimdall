{ config, lib, ... }:
with lib;
with lib.heimdall;
  let cfg = config.desktops.hyprland;
in
{
  imports = lib.snowfall.fs.get-non-default-nix-files ./.;

  options.desktops.hyprland = {
    enable = mkEnableOption "Enable hyprland window manager";
    execOnceExtra = mkOption {
      type = listOf str;
      description = "Extra programs to exec once";
    };
  };

  config = mkIf cfg.enable {
    desktops.addons = {
      rofi.enable = true;
      waybar.enable = true;
      wlsunset.enable = true;

      hyprpaper.enable = true;
      hyprlock.enable = true;
      hypridle.enable = true;
    };
  };
}
