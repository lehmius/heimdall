{ config, lib, ... }:
with lib;
with lib.heimdall; let
  cfg = config.hardware.networking;
in {
  options.hardware.networking = {
    enable = mkEnableOption "Enable networkmanager";
  };

  config = mkIf cfg.enable {
    networking.firewall = {
      enable = true;
    };
    networking.networkmanager.enable = true;
  };
}