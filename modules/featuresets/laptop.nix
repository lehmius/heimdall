{ config, ... }:
{
  config.flake = {
    nixos.laptop.imports = with config.flake.nixos.modules; [
      pc
    ];

  homeManager.laptop.imports = with config.flake.homeManager.modules; [];
  };
}
