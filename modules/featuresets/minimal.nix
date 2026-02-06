{ config, ... }:
{
    flake.modules = {
      nixos.minimal.imports = with config.flake.modules.nixos;[

      ];

      homeManager.minimal.imports = with config.flake.modules.homeManager; [
        git
      ];
    };
}
