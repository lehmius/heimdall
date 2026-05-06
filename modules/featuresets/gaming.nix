{ config, ... }:
{
  flake.modules = {
    nixos.gaming.imports = with config.flake.modules.nixos; [
      # lutris
      steam
      vintagestory
    ];
    homeManager.gaming.imports = with config.flake.modules.homeManager; [
    ];
  };
}
