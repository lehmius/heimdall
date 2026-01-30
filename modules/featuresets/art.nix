{ config, ... }:
{
  flake.modules =
  {
    nixos.art =  { pkgs, ... }:
    {
      environment.systemPackages = with pkgs; [
        blender
        gimp2
        inkscape
        krita
        libresprite
      ];
    };

    homeManager.art =  { pkgs, ... }:
    {
      home.packages = with pkgs; [
        blender
        gimp2
        inkscape
        krita
        libresprite
      ];
    };
  };
}
