{
  config,
  pkgs,
  lib,
  inputs,
  ...
}: 
with lib; let
  cfg = config.common.core.neovim;
in {
  options.common.core.neovim.enable = mkEnableOption "Enable neovim";

  config = mkIf cfg.enable {
    program.neovim = {
      enable = true;
      plugins = [ inputs.vimsical ];
    };
  };
}
