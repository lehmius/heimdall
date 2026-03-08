{ inputs, ... }:
{
  flake.modules.nixos.framework = {
    imports = [
      inputs.nixos-hardware.nixosModules.framework-13-7040-amd
    ];
  };
}
