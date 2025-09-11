{
  config,
  lib,
  pkgs,
  ...
}: {
  home.username = lib.mkDefault "lehmius";
  home.homeDirectory = lib.mkDefault "/home/${config.home.username}";

  home.stateVersion = "25.05";

  home.packages = with pkgs; [
    nerd-fonts.fira-code
  ];

  home.file = {
  };

  home.sessionVariables = {
  };

  programs.home-manager.enable = true;
}
