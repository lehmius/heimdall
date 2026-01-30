{ config, ... }:
{
  config.flake.modules.nixos.minimal = {
    nix = {
      settings = {
        experimental-features = [ "nix-command" "flakes" ];
        trusted-users = [
          "root"
          "lehmius"
        ];
      };
      gc = {
        automatic = true;
        options = "--delete-older-than 30d";
      };
      optimise.automatic = true;
    };
  };
}
