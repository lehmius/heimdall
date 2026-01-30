{ config, ... }:
{
  flake.modules.homeManager.minimal = args: {
    programs.home-manager.enable = true;
    systemd.user.startServices = "sd-switch";
  };
}
