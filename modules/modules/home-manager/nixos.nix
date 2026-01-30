{ config, inputs, ... }:
{
  flake.modules.nixos = {
    minimal = {
      imports = [ inputs.home-manager.nixosModules.home-manager ];
      home-manager = {
        useGlobalPkgs = true;
        extraSpecialArgs.hasGlobalPkgs = true;
      };
    };
  };
}
