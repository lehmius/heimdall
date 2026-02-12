# Originally by mightyiam: https://github.com/mightyiam/infra/blob/1e32004d75b417053096ff1ed7e981d2b9a8cbf3/modules/nixpkgs/nix-path.nix
{
  flake.modules.nixos.minimal = nixosArgs: {
    nix.nixPath = [
      "nixpkgs=${nixosArgs.config.nixpkgs.flake.source}"
    ];
  };
}
