{ config, ... }:
{
    flake.modules = {
      nixos.core.imports = [

      ];

      homeManager.core.imports = with config.flake.modules.homeManager; [
        direnv
      ];
    };
}
