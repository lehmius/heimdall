
{ config, ... }:
{
  config.flake.modules.nixos.messaging.discord = { pkgs, ... }:
  {
    environment.systemPackages = with pkgs; [
      discord
    ];
  };
}
