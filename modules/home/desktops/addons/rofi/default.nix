{ config, pkgs, lib, ... }:
with lib;
with lib.heimdall;
let
  cfg = config.desktops.addons.rofi;
in
{
  options.desktops.addons.rofi = {
    enable = mkEnableOption "Enable rofi app launcher";
    package = mkPackageOption {
      description = "Package to use for rofi";
      default = pkgs.rofi-wayland;
    };
  };

  config = mkIf cfg.enable {
    programs.rofi = {
      enable = true;
      package = cfg.package;
      terminal = "${home.sessionVariables.TERM}/bin/${home.sessionVARIABLES.TERM}";
      extraConfig = {
        show-icons = true;
      };
    };
  };
}
