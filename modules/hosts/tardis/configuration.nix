# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{ self, config, ...}:
{
  configurations.nixos.tardis.module =
  { lib, pkgs, ... }:
  {
    imports = with config.flake.modules.nixos; [
      pc
      ai
      gaming
      programming
      lehmius
    ] ++ [
      self.nixosModules.nvidia-gpu
    ];

    # Bootloader.
    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;

    # Use latest kernel.
    boot.kernelPackages = lib.mkForce pkgs.linuxPackages_latest;

    networking.hostName = "tardis";
    networking.networkmanager = {
      enable = true;
      plugins = with pkgs; [
        networkmanager-openconnect
      ];
    };
    services.openssh.enable = true;

    # Enable the X11 windowing system.
    services.xserver = {
      enable = true;
      videoDrivers = [ "nvidia" ];
      xkb = {
        layout = "us";
        variant = "colemak";
      };
    };
    console.keyMap = "colemak";

    services = {
      displayManager.gdm.enable = true;
      desktopManager.gnome = {
        enable = true;
        extraGSettingsOverrides = ''
          [org.gnome.mutter]
          experimental-features=['scale-monitor-framebuffer', 'xwayland-native-scaling']
        '';
      };
    };

    # Enable CUPS to print documents.
    services.printing.enable = true;

    environment.sessionVariables = {
      EDITOR = "nvim";
      VISUAL = "nvim";
    };

    # Allow unfree packages
    nixpkgs.config.allowUnfree = true;

    # List packages installed in system profile. To search, run:
    # $ nix search wget
    environment.systemPackages = with pkgs; [
      ausweisapp
      davinci-resolve
      neovim
      librewolf
      anki-bin
      obsidian
      libreoffice-qt6-fresh
      openconnect
      networkmanager-openconnect
      virt-manager
      qemu
      nix-ld
      obs-studio
      zotero
    ];

    system.stateVersion = "25.05";
  };
}
