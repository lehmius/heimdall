{ config, ... }:
{
  configurations.nixos.tardis.module = {
    imports = with config.flake.modules.nixos; [
      pc
      programming
      lehmius
    ];
  };
}
