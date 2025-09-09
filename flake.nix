{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    nvf.url = "github:NotAShelf/nvf";
  };

  outputs = { self, nixpkgs, nvf, ... } @ inputs: 
  let
    inherit (self) outputs;
    systems = [
      "x86_64-linux"
    ];
    forAllSystems = nixpkgs.lib.genAttrs systems;
  in
  {
    overlays = import ./overlays { inherit inputs; };
    nixosConfigurations = {
      workstation = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs outputs; };
	modules = [
	  ./configuration.nix
	  nvf.nixosModules.default
	];
      };
    };
  };
}
