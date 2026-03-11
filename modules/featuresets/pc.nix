{ config, ... }:
{
  flake.modules = {
    nixos.pc = { pkgs, ... }: {
      imports = with config.flake.modules.nixos; [
        minimal
        audio
      ];
      environment.systemPackages = with pkgs; [
        ghostty
      ];
    };
    homeManager.pc.imports = with config.flake.modules.homeManager; [
      minimal
    ];
  };
}
