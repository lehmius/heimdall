{ config, lib, ... }:
with lib;
with lib.heimdall; let
  cfg = config.system.nix;
in {
  options.system.nix = {
    enable = mkEnableOption "Whether or not to manage nix configuration";
  };

  config = mkIf cfg.enable {
    nix = {
      settings = {
        trusted-users = ["@wheel" "root"];
        auto-optimise-store = lib.mkDefault true;
        use-xdg-base-directories = true;
        experimental-features = ["nix-command" "flakes"];
        warn-dirty = false;
        system-features = ["kvm" "big-parallel" "nixos-test"];
      };

      # flake-utils-plus
      generateRegistryFromInputs = true;
      generateNixPathFromInputs = true;
      linkInputs = true;
    };
  };
}