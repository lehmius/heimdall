{ pkgs, ... }:
pkgs.mkShell {
  NIX_CONFIG = "extra-experimental-features = nix-command flakes";

  packages = with pkgs; [
    nh

    git
    alejandra
    statix
    deadnix
    home-manager
    sops
    ssh-to-age
    gnupg
    age
  ];
}