{ config, pkgs, lib, ... }:
with lib;
with lib.heimdall;
let
  cfg = config.system.nix;
in
{
  options.system.nix = {
    enable = mkEnableOption "Manage nix configuratino";
  };

  config = mkIf cfg.enable {
    home-packages = with pkgs; [
      nixgl nix-output-monitor nvd
    ];

    systemd.user.startServices = "sd-switch";

    programs = { home-manager.enable = true; };

    home.sessionVariables = {
      NH_FLAKE = "/home/${config.heimdall.user.name}/heimdall";
    };

    nix = {
      experimental-features = [ "nix-command" "flakes" ];
      warn-dirty = false;
      use-xdg-base-directories = true;
    };

    news = {
      display = "silent";
      json = lib.mkForce { };
      entries = lib.mkForce [ ];
    };
  };
}
