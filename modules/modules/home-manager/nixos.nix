{ config, inputs, ... }:
{
  flake.modules.nixos = {
    core = {
      imports = [ inputs.home-manager.nixosModules.home-manager ];
      home-manager = {
        uesGlobalPkgs = true;
        extraSpecialArgs.hasGlobalPkgs = true;
      };
    };
  };
}
