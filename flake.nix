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

	nixos-hardware.url = "github:nixos/nixos-hardware"; 

	sops-nix = {
	  url = "github:Mic92/sops-nix";
	  inputs.nixpkgs.follows = "nixpkgs";
	};

	nixos-anywhere = {
	  url = "github:numtide/nixos-anywhere";
	  inputs.nixpkgs.follows = "nixpkgs";
	  inputs.disko.follows = "disko";
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
	    disko.nixosModules.disko
	    sops-nix.nixosModules.sops
        ];

	systems.hosts.framework.modules = with inputs; [
	  nixos-hardware.nixosModules.frakework-13-7040-amd
	];

    };
}
