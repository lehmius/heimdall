{ options, config, lib, pkgs, ... }:
with lib;
with lib.heimdall;
let 
  cfg = config.module;
in 
{
  options.module = with types; {
    enable = mkEnableOption "Enable module.";
  }

  config = mkIf cfg.enable {

  };
}