{ config, ... }:
{
  config.flake.modules.nixos.minimal = {
    nix = {
      settings = {
        experimental-features = [ "nix-command" "flakes" ];
        trusted-users = [
          "root"
        ];
      };
      gc = {
        automatic = true;
        options = "--delete-older-than 14d";
        persistent = true;
      };
      optimise.automatic = true;
    };
  };
}
