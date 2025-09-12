{
  description = "My NixOS configuration heimdall"; 

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-25.05";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    vimsical.url = "github:lehmius/vimsical";
  };

  outputs = {
    self,
    home-manager,
    nixpkgs,
    ...
    } @ inputs: let
      inherit (self) outputs;
      systems = [
        "x86_64-linux"
      ];
      forAllSystems = nixpkgs.lib.genAttrs systems;
    in
    {
      packages = 
        forAllSystems (system: import ./pkgs nixpkgs.legacyPackages.${system});
      overlays = import ./overlays { inherit inputs; };
      nixosConfigurations = {
        workstation = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs outputs; };
	  modules = [
	    ./hosts/workstation
	  ];
        };
      };
      homeConfigurations = {
        "lehmius@workstation" = home-manager.lib.homeManagerConfiguration {
	  pkgs = nixpkgs.legacyPackages."x86_64-linux";
	  extraSpecialArgs = { inherit inputs outputs; };
	  modules = [
	    ./home/lehmius/workstation.nix
	  ];
	};
      };
    };
}
