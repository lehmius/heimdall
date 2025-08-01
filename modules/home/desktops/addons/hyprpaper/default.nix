{ config, lib, ... }:
with lib;
with lib.heimdall;
let
  cfg = config.desktops.addons.hyprpaper;
in
{
  options.desktops.addons.hyprpaper = {
    enable = mkEnableOption "Enable hyprpaper";
  };

  config = mkIf cfg.enable {
    services.hyprpaper.enable = true;
  };
}
