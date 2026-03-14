{ config, ...}:
{
  flake.modules.homeManager.lehmius = { pkgs, ... }:
  {
    imports = with config.flake.modules.homeManager; [
      minimal
      programming
      ghostty
    ];
    home = {
      username = config.flake.meta.users.lehmius.username;
      homeDirectory = "/home/${config.flake.meta.users.lehmius.username}";
      file.".config" = { # I don't currently know how to replace .config with ${config.xdg.configHome} which would be better.
        source = ./dotfiles;
        recursive = true;
      };
      packages = with pkgs; [
        nerd-fonts.fira-code
        signal-desktop
        calibre
      ];
    };
  };
}
