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

      home-manager.users.${config.flake.meta.users.lehmius.username}.imports = with config.flake.modules.homeManager;[
        (
          { osConfig, ... }:
          {
            home.stateVersion = osConfig.system.stateVersion;
          }
        )
        minimal
        programming
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
