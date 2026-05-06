{ inputs, ... }:
{
  nixpkgs.config.allowUnfreePackages = [ "vintagestory" ];
  flake.modules.nixos.vintagestory = { pkgs, ... }:
  {
    nixpkgs.overlays = [ inputs.vintagestory-nix.overlays.default ];
    environment.systemPackages = [
      (pkgs.vintagestoryPackages.latest.override {
        waylandSupport = true;
      })
    ];
  };
}
