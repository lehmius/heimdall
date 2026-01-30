{ config, ... }:
{
  flake.modules.nixos.gaming.vintagestory = { pkgs, ... }:
  {
    services.flatpak.enable = true;
    systemd.services.flatpak-repo = {
      wantedBy = [ "multi-user.target" ];
      path = [ pkgs.flatpak ];
      script = ''
        flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
        flatpak install --or-update flathub at.vintagestory.VintageStory
      '';
    };
  };
}
