{ config, inputs, ... }:
{
  flake.modules.nixos = {
    core = {
      imports = [ inputs.home-manager.nixosModules.home-manager ];
      home-manager = {
        useGlobalPkgs = true;
        extraSpecialArgs.hasGlobalPkgs = true;
      };
    };
  };
}
