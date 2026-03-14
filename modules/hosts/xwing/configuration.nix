{ config, ... }:
{
  configurations.nixos.xwing.module =
  { lib, pkgs, ... }:
  {
    imports = with config.flake.modules.nixos; [
      pc
      framework
      gamedev
      lehmius
      mangowc
    ];

    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;

    boot.kernelPackages = pkgs.linuxPackages_latest;

    networking.hostName = "xwing";
    networking.networkmanager.enable = true;

    services.xserver = {
      enable = true;
      xkb = {
        layout = "us";
        variant = "colemak";
      };
    };
    console.keyMap = "colemak";

    services = {
      displayManager.ly.enable = true;
      desktopManager.gnome = {
          enable = true;
          extraGSettingsOverrides = ''
              [org.gnome.mutter]
              experimental-features=['scale-monitor-framebuffer', 'xwayland-native-scaling']
          '';
      };
    };

    services.printing.enable = true;
    environment.systemPackages = with pkgs; [
        neovim
        git
        librewolf
        signal-desktop
        swaybg
        anki-bin
    ];

    system.stateVersion = "25.05";
  };
}
