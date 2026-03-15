{ config, ... }:
{
  configurations.homeManager.lehmius.module = {
    imports = [
      config.flake.modules.homeManager.hyprland
    ];

    hyprland = {
      enable = true;
      settings = {
        "$mod" = "SUPER";
        "$menu" = "";
        bind =
        let
          hjkl =
            mod: f:
            {
              h = "l";
              j = "d";
              k = "u";
              l = "r";
            }
            |> lib.mapAttrsToList (k: d: "${mod}, ${k}, ${f d}");
        in
        lib.concatLists [
          [
            "$mod, Q, killactive"
            "$mod, RETURN, exec, ghostty"
            "$mod, SPACE, exec, $menu"
            "$mod, B, exec, librewolf"
          ]
          (hjkl "SUPER" (d: "movefocus, ${d}"))
        ];
        input = [
          "kb_layout = us"
          "kb_variant = colemak"
          "repeat_rate = 35"
          "repeat_delay = 200"
          "natural_scroll = true"
        ];
      };
    };
  };
}
