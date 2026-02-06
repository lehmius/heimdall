{ config, ...}:
{
  flake =
  {
    meta.users.lehmius = {
      name = "Felix Clajus";
      username = "lehmius";
      email = "lehmius@clajus.eu";
    };

    modules.nixos.lehmius = {
      users.users.lehmius = {
        isNormalUser = true;
        description = "lehmius";
        extraGroups = [
          "networkmanager"
          "wheel"
          "libvirtd"
          "flatpak"
          "audio"
          "video"
          "input"
          "kvm"
          "qemu-libvirtd"
        ];
      };

      nix.settings.trusted-users = [ "lehmius" ];

      home-manager.users.${config.flake.meta.users.lehmius.username}.imports = with config.flake.modules.homeManager;[
        minimal
        lehmius
      ];
    };

    modules.homeManager.lehmius = { pkgs, ... }:
    {
      imports = [
        config.flake.modules.homeManager.minimal
      ];
      home = {
        username = config.flake.meta.users.lehmius.username;
        homeDirectory = "/home/${config.flake.meta.users.lehmius.username}";
        stateVersion = "25.05";
        packages = with pkgs; [
          nerd-fonts.fira-code
          signal-desktop
          discord
          brave
          calibre
        ];
      };
    };
  };
}
