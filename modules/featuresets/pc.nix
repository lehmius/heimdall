{ config, ... }:
{
  flake.modules = {
    nixos.pc.imports = with config.flake.modules.nixos; [
      minimal
      audio
    ];
    homeManager.pc.imports = with config.flake.modules.homeManager; [
      minimal
    ];
  };
}
