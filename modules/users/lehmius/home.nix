{ config, ...}:
{
  flake =
  {
    meta.users.lehmius = {
      name = "Felix Clajus";
      username = "lehmius";
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

      home-manager.users.${config.flake.meta.users.lehmius.username}.imports = with config.flake.modules.homeManager;[
        core
        lehmius
      ];
    };

    modules.homeManager.lehmius = { pkgs, ... }:
    {
      imports = [
        config.flake.modules.homeManager.core
      ];
      home = {
        username = config.flake.meta.users.lehmius.username;
        homeDirectory = "/home/${config.flake.meta.users.lehmius.username}";
        stateVersion = "25.05";
        packages = with pkgs; [
          nerd-fonts.fira-code
          signal-desktop
          blender
          godot
          vscode
          ripgrep
          bat
          vscode
          discord
          brave
          calibre
          inkscape
        ];
      };
    };
  };
}
