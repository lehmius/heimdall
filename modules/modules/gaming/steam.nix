{ config, ... }:
{
  nixpkgs.config.allowUnfreePackages = [
    "steam"
    "steam-unwrapped"
  ];
  flake.modules.nixos.steam = { pkgs, ... }:
  {
    environment.sessionVariables = {
      STEAM_EXTRA_COMPAT_TOOLS_PATH =
        "/home/lehmius/.steam/root/compatibilitytools.d";
    };
    environment.systemPackages = with pkgs; [
      protonup-ng
    ];
    programs.steam = {
      enable = true;
      gamescopeSession.enable = true;
    };
    programs.gamemode.enable = true;
  };
}
