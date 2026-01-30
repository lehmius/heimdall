{ config, ... }:
{
  config.flake.modules.nixos.browsers.brave = { pkgs, ... }:
  {
    environment.systemPackages = with pkgs; [
      brave
    ];
  };
}
