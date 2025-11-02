{
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [
  #  ./neovim.nix
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
  ];

  home.sessionVariables = {
  };

  programs.home-manager.enable = true;
}
