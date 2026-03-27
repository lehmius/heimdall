{ self, inputs, ... }:
{
  flake.nixosModules.niri = { pkgs, lib, ... }:
  {
    programs.niri = {
      enable = true;
      package = self.packages.${pkgs.stdenv.hostPlatform.system}.niri;
    };
  };

  perSystem = { pkgs, lib, self', ... }:
  {
    packages.niri = inputs.wrapper-modules.wrappers.niri.wrap {
      inherit pkgs;
      settings = {
        spawn-at-startup = [
          # (lib.getExe self'.packages.dankMaterialShell)
        ];

        input.keyboard.xkb.layout = "colemak, de";
        layout.gaps = 3;
        binds = {
          "Mod+Return".spawn-sh = lib.getExe pkgs.wezterm;
          "Mod+Q".close-window = null;
        };
      };
    };
  };
}
