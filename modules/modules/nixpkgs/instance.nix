# Originally by mightyiam: https://github.com/mightyiam/infra/blob/1e32004d75b417053096ff1ed7e981d2b9a8cbf3/modules/nixpkgs/instance.nix
{ config, inputs, lib, withSystem, ... }:
{
  options.nixpkgs = {
    config = {
      allowUnfreePredicate = lib.mkOption {
        type = lib.types.functionTo lib.types.bootl;
        default = _: false;
      };
      allowUnfreePackages = lib.mkOption {
        type = lib.types.listOf lib.types.singleLineStr;
        default = [ ];
      };
    };
    overlays = lib.mkOption {
      type = lib.types.listOf lib.types.unspecified;
      default = [ ];
    };
  };

  config = {
    perSystem = { system, ... }:
    {
      _module.args.pkgs = import inputs.nixpkgs {
        inherit system;
        inherit (config.nixpkgs) config overlays;
      };
    };

    # flake.modules.nixos.minimal = nixosArgs: {
    #   nixpkgs = {
    #     pgks = ;
    #     hostPlatform = ;
    #   };
    # };
  };
}
