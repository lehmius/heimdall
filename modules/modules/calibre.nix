{ config, ... }:
{
  config.flake.modules = {
    nixos.calibre = {
      services.udisks2 = {
        enable = true;
        mountOnMedia = true;
      };
    };
    homeManager.calibre.programs.calibre = {
      enable = true;
      plugins = [ ];
    };
  };
}
