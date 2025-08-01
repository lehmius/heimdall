{ pkgs, config, lib, host, ... }:
with lib;
with lib.heimdall;
let
  cfg = config.cli.shells.nushell;
in
{
  options.cli.shells.nushell = {
    enable = mkEnableOption "Enable nu shell";
  };

  config = mkIf cfg.enable {
    programs.nushell = {
      enable = true;
    };
  };
}
