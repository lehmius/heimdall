{ config, ...}:
{
  flake.modules.homeManager.lehmius = { pkgs, ... }:
  {
    imports = with config.flake.modules.homeManager; [
      minimal
      programming
    ];
    home = {
      username = config.flake.meta.users.lehmius.username;
      homeDirectory = "/home/${config.flake.meta.users.lehmius.username}";
      stateVersion = "25.05";
      packages = with pkgs; [
        nerd-fonts.fira-code
        signal-desktop
        calibre
        mangowc
      ];
    };
  };
}
