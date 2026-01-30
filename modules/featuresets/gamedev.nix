{ config, ... }:
{
  config.flake.modules =
  {
    nixos.gamedev = { pkgs, ... }: {
      imports = with config.flake.modules.nixos; [
        art
        programming
      ];
      environment.systemPackager = with pkgs; [
        godot
      ];
    };
    homeManager.gamedev.imports = with config.flake.modules.homeManager; [
      art
      programming
    ];
  };
}
