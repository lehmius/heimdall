{ config, lib, pkgs, ... }: 
let
  inherit (lib) mkIf;

  cfg = config.system.boot;
in {
  options.system.boot = {
    enable = mkEnableOption "Whether or not to enable booting.";
    plymouth = mkEnableOption "Whether or not to enable plymouth boot splash.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs;
      [
        efibootmgr
        efitools
        efivar
        fwupd
      ];

    boot = {
      kernelParams = lib.optionals cfg.plymouth ["quiet" "splash" "loglevel=3" "udev.log_level=0"];
      initrd.systemd.enable = true;

      loader = {
        efi = {
          canTouchEfiVariables = true;
        };

        systemd-boot = {
          enable = true;
          configurationLimit = 20;
          editor = false;
        };
      };

      plymouth = {
        enable = cfg.plymouth;
      };
    };

  };
}