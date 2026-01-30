{ config, ... }:
{
  config.flake.modules = {
    nixos.programming.imports = with config.flake.modules.nixos; [];

    homeManager.programming.imports = with config.flake.modules.homeManager; [
      git
      direnv
    ];
  };
}
