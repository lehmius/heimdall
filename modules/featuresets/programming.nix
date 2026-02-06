{ config, ... }:
{
  flake.modules = {
    nixos.programming.imports = with config.flake.modules.nixos; [

    ];
    homeManager.programming = { pkgs, ... }:
    {
      imports = with config.flake.modules.homeManager; [
        direnv
        zed-editor
      ];
      home.packages = with pkgs; [
        ripgrep
        bat
        fzf
      ];
    };
  };
}
