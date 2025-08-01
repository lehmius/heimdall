{ lib, config, ... }:
with lib;
with lib.heimdall;
let
  cfg = config.suites.desktop;
in {
  options.suites.desktop = {
    enable = mkEnableOption "Enable desktop configuration";
  };

  config = mkIf cfg.enable {

    suites = {
      common.enable = true;

      desktop.addons = {
        hyprland.enable = true;
      };
    };

    hardware = {
      audio.enable = true;
    };

    system = {
      boot.plymouth = true;
    };

    user = {
      name = "lehmius";
      initialPassword = "heimdall";
    };
  };
}