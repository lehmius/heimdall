# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, inputs, outputs, ... }:

{
  imports = [
    ./hardware-configuration.nix
  ];

  # Bootloader.
  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
    kernelPackages = pkgs.linuxPackages_latest;
  };

  networking.hostName = "workstation";
  networking.networkmanager.enable = true;
  services.openssh = {
    enable = true;
  };

#  networking.openconnect.interfaces = {
#    openconnect0 = {
#      gateway = "vpn.hrz.tu-darmstadt.de";
#      protocol = "anyconnect";
#      user = "fc74fyje";
#      passwordFile = ./vpn.passwd;
#      extraOptions = {
#      	usergroup = "campus";
#        cafile = ./rootcert.crt;
#      };
#    };
#  };

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

  services.displayManager.gdm.enable = true;
  services.desktopManager.gnome.enable = true;
  services.xserver = {
    enable = true;
    videoDrivers = [ "nvidia" ];
    xkb = {
      layout = "us";
      variant = "colemak";
    };
  };
  console.keyMap = "colemak";

  hardware.graphics.enable = true;

  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement = {
      enable = false;
      finegrained = false;
    };
    open = false;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };

  services.printing.enable = true;

  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };

  environment.sessionVariables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
    STEAM_EXTRA_COMPAT_TOOLS_PATH = 
      "/home/lehmius/.steam/root/compatibilitytools.d";
  };

  environment.systemPackages = with pkgs; [
      neovim
      librewolf
      anki-bin
      obsidian
      libresprite
      protonup-ng
      heroic
      libreoffice-qt6-fresh
      openconnect
      networkmanager-openconnect
    ];

  programs.git = {
    enable = true;
    config = {
      init.defaultBranch = "dev";
      url."https://github.com/".insteadOf = [
        "github:"
      ];
    };
  };

  programs.steam = {
    enable = true;
    gamescopeSession.enable = true;
  };
  programs.gamemode.enable = true;

  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.05";
}
