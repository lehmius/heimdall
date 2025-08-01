{
    description = "Lehmius' Nix/NixOS Config";
    
    inputs = {
        nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";
        nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

        home-manager = {
            url = "github:nix-community/home-manager/release-25.05";
            inputs.nixpkgs.follows = "nixpkgs";
        };

        snowfall-lib = {
            url = "github:snowfallorg/lib";
            inputs.nixpkgs.follows = "nixpkgs";
        };

	disko = {
	  url = "github:nix-community/disko";
	  inputs.nixpkgs.follows = "nixpkgs";
	};
    };

    outputs = inputs:
    let
        lib = inputs.snowfall-lib.mkLib {
            inherit inputs;
            src = ./.;

            snowfall = {
                metadata = "heimdall";
                namespace = "heimdall";
                meta = {
                    name = "heimdall";
                    title = "Lehmius' Nix Flake";
                };
            };
        };
    in lib.mkFlake {
        channels-config = {
            allowUnfree = true;
        };

        systems.modules.nixos = with inputs; [
            home-manager.nixosModules.home-manager
        ];

    };
}
