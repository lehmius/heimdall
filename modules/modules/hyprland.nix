{ inputs, ... }:
{
  flake.modules = {
    # NixOS module needs to be imported to add desktop session file for the display manager.
    nixos.hyprland = {
      imports = [ inputs.hyprland.nixosModules.default ];
      programs.hyprland.enable = true;
    };
    homeManager.hyprland = { lib, config, ... }:
    let
      cfg = config.hyprland;
    in
    {
      options.hyprland = {
        enable = lib.mkEnableOption "Enable the hyprland wayland compositor.";
        # Tracks options of the home-manager module from hyprland itself.
        # See: https://github.com/hyprwm/Hyprland/blob/main/nix/module.nix
        plugins = lib.mkOption {
          type = with lib.types; listOf (either package path);
          default = [ ];
          description = ''
            List of Hyprland plugins to use. Can either be packages or
            absolute plugin paths.
          '';
        };

        settings = lib.mkOption {
          type =
            with lib.types;
            let
              valueType =
                nullOr (oneOf [
                  bool
                  int
                  float
                  str
                  path
                  (attrsOf valueType)
                  (listOf valueType)
                ])
                // {
                  description = "Hyprland configuration value";
                };
            in
            valueType;
          default = { };
          description = ''
            Hyprland configuration written in Nix. Entries with the same key
            should be written as lists. Variables' and colors' names should be
            quoted. See <https://wiki.hypr.land> for more examples.

            Special categories (e.g `devices`) should be written as
            `"devices[device-name]"`.

            ::: {.note}
            Use the [](#programs.hyprland.plugins) option to
            declare plugins.
            :::

          '';
          example = lib.literalExpression ''
            {
              decoration = {
                shadow_offset = "0 5";
                "col.shadow" = "rgba(00000099)";
              };

              "$mod" = "SUPER";

              bindm = [
                # mouse movements
                "$mod, mouse:272, movewindow"
                "$mod, mouse:273, resizewindow"
                "$mod ALT, mouse:272, resizewindow"
              ];
            }
          '';
        };

        extraConfig = lib.mkOption {
          type = lib.types.lines;
          default = "";
          example = ''
            # window resize
            bind = $mod, S, submap, resize

            submap = resize
            binde = , right, resizeactive, 10 0
            binde = , left, resizeactive, -10 0
            binde = , up, resizeactive, 0 -10
            binde = , down, resizeactive, 0 10
            bind = , escape, submap, reset
            submap = reset
          '';
          description = ''
            Extra configuration lines to add to `/etc/xdg/hypr/hyprland.conf`.
          '';
        };
      };
      config = {
        wayland.windowManager.hyprland = {
          enable = cfg.enable;
          plugins = cfg.plugins;
          settings = cfg.settings;
          extraConfig = cfg.extraConfig;
        };
      };
    };
  };
}
