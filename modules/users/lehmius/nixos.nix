{ config, ... }:
{
  flake.modules.nixos.lehmius = {
    users.users.lehmius = {
      isNormalUser = true;
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

    nix.settings.trusted-users = [ config.flake.meta.users.lehmius.username ];

    home-manager.users.${config.flake.meta.users.lehmius.username}.imports = with config.flake.modules.homeManager;[
      lehmius
    ];
  };
}
