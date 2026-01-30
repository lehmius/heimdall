{ config, ... }:
{
    flake.modules = {
      nixos.minimal.imports = [

      ];

      homeManager.minimal.imports = with config.flake.modules.homeManager; [
        direnv
      ];
    };
}
