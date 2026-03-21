{ config, lib, ... }:
{
  configurations.homeManager.lehmius.module = {
    imports = [
      config.flake.modules.homeManager.hyprland
    ];

    hyprland = {
      enable = true;
      terminal = "wezterm";
      settings = {
        bind =
        let
          # function by: https://github.com/mightyiam/infra/blob/2b6891c18991117975c6096c8b20810908ef427c/modules/window-manager/hyprland/window-management.nix#L6
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
            "$mod, RETURN, exec, $terminal"
            "$mod, SPACE, exec, $menu"
            "$mod, B, exec, librewolf"
          ]
          (hjkl "$mod" (d: "movefocus, ${d}"))
	  # workspace navigation by mightyiam:
	  # https://github.com/mightyiam/infra/blob/2b6891c18991117975c6096c8b20810908ef427c/modules/window-manager/hyprland/window-management.nix#L6
	  (
	    9
	    |> lib.genList toString
	    |> map (ws: [
	      "$mod, ${ws}, workspace, ${ws}"
	      "$mod+SHIFT, ${ws}, movetoworkspace, ${ws}"
	    ])
	    |> lib.concatLists
	  )
        ];
        input = {
          "kb_layout" = "us";
          "kb_variant" = "colemak";
          "repeat_rate" = 35;
          "repeat_delay" = 200;
          "natural_scroll" = true;
        };
      };
    };
  };
}
