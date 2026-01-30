{ config, ... }:
{
  flake.modules.home-manager.gaming.steam = { pkgs, ... }:
  {
    home.sessionVariables = {
      STEAM_EXTRA_COMPAT_TOOLS_PATH =
        "/home/lehmius/.steam/root/compatibilitytools.d";
    };
    home.packages = with pkgs; [
      protonup-ng
    ];
    programs.steam = {
      enable = true;
      gamescopeSession.enable = true;
    };
    programs.gamemode.enable = true;
  };
}
