{
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [
    direnv.nix
  ];

  home.username = lib.mkDefault "lehmius";
  home.homeDirectory = lib.mkDefault "/home/${config.home.username}";

  home.stateVersion = "25.05";

  home.packages = with pkgs; [
    nerd-fonts.fira-code
    signal-desktop
    blender
    godot
    vscode
    ripgrep
    bat
    vscode
    discord
    brave
    calibre
    inkscape
  ];

  home.sessionVariables = {
  };

  programs.home-manager.enable = true;
}
