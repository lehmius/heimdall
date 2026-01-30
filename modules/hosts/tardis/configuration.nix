# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{ config, ...}:
{
  configurations.nixos.tardis.module =
  { lib, pkgs, ... }:
  {
    # Bootloader.
    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;

    # Use latest kernel.
    boot.kernelPackages = lib.mkForce pkgs.linuxPackages_latest;

    networking.networkmanager.enable = true;
    services.openssh.enable = true;

    time.timeZone = "Europe/Berlin";
    i18n.defaultLocale = "en_US.UTF-8";
    i18n.extraLocaleSettings = {
      LC_ADDRESS = "de_DE.UTF-8";
      LC_IDENTIFICATION = "de_DE.UTF-8";
      LC_MEASUREMENT = "de_DE.UTF-8";
      LC_MONETARY = "de_DE.UTF-8";
      LC_NAME = "de_DE.UTF-8";
      LC_NUMERIC = "de_DE.UTF-8";
      LC_PAPER = "de_DE.UTF-8";
      LC_TELEPHONE = "de_DE.UTF-8";
      LC_TIME = "de_DE.UTF-8";
    };

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
          experimental-features=['scale-monitor-framebuffer']
        '';
      };
    };

    # Enable the GNOME Desktop Environment.
    services.flatpak.enable = true;
    systemd.services.flatpak-repo = {
      wantedBy = [ "multi-user.target" ];
      path = [ pkgs.flatpak ];
      script = ''
        flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
        flatpak install --or-update flathub at.vintagestory.VintageStory
      '';
    };

    hardware.graphics.enable = true;
    hardware.nvidia = {
      modesetting.enable = true;
      powerManagement = {
        enable = false;
        finegrained = false;
      };
      open = false;
      nvidiaSettings = true;
    };

    # Enable CUPS to print documents.
    services.printing.enable = true;

    environment.sessionVariables = {
      EDITOR = "nvim";
      VISUAL = "nvim";
      STEAM_EXTRA_COMPAT_TOOLS_PATH =
        "/home/lehmius/.steam/root/compatibilitytools.d";
    };

    # Allow unfree packages
    nixpkgs.config.allowUnfree = true;

    # List packages installed in system profile. To search, run:
    # $ nix search wget
    environment.systemPackages = with pkgs; [
      neovim
      librewolf
      anki-bin
      obsidian
      libresprite
      protonup-ng
      libreoffice-qt6-fresh
      openconnect
      networkmanager-openconnect
      virt-manager
      qemu
      zed-editor
      nix-ld
      obs-studio
      zotero
      direnv
    ];

    programs.steam = {
      enable = true;
      gamescopeSession.enable = true;
    };
    programs.gamemode.enable = true;

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
