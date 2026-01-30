{ config, ... }:
{
  flake.modules.homeManager.core = args: {
    programs.home-manager.enable = true;
    systemd.user.startServices = "sd-switch";
  };
}
