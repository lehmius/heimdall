{ config, ... }:
{
  config.flake.modules.nixos.messaging.signal = { pkgs, ... }:
  {
    environment.systemPackages = with pkgs; [
      signal-desktop
    ];
  };
}
