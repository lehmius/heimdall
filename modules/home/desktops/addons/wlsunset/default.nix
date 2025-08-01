{ config, lib, ... }:
with lib;
with lib.heimdall;
let
  cfg = config.desktops.addons.wlsunset;
in
{
  options.desktops.addons.wlsunset = {
    enable = mkEnableOption "Enable wlsunset";
  };

  config = mkIf cfg.enable {
    services.wlsunset = {
      enable = true;
      latitude = "50.1155";
      longitude = "8.6841";
    };
  };
}
