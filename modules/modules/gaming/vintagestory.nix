{ inputs, ... }:
{
  nixpkgs.config.allowUnfreePackages = [ "vintagestory" ];
  flake.modules.nixos.vintagestory = { pkgs, ... }:
  {
    nixpkgs.overlays = [ inputs.vintagestory-nix.overlays.default ];
    environment.systemPackages = with pkgs; [
      vintagestoryPackages.latest
    ];
  };
}
