{ config, ... }:
{
  flake.modules.nixos.ai.imports = with config.flake.modules.nixos; [
    tika
  ];
}
