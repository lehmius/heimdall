{ config, pkgs, lib, ... }:
with lib;
with lib.heimdall;
let
  cfg = config.suites.common;
in
{
  options.suites.common = {
    enable = mkEnableOption "Enable the common configuration";
  };

  config = mkIf cfg.enable {
    system = {
      nix.enable = true;
    };

    cli = {
      terminals.ghostty.enable = true;
      shells.nushell.enable = true;
    };

    browsers.librewolf.enable = true;

    home.packages = with pkgs; [
    ];
  };
}
