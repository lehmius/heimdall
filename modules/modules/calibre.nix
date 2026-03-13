{ self, ... }:
{
  flake.modules = {
    nixos.calibre = {
      services.udisks2 = {
        enable = true;
        mountOnMedia = true;
      };
    };
    homeManager.calibre.programs.calibre = {
      imports = [ self.flake.modules.nixos.calibre ]; # Note this does not work when using home-manager standalone.
      enable = true;
      plugins = [ ];
    };
  };
}
