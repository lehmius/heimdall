{
  flake.modules.homeManager.hyprland = { pkgs, ... }: {
    wayland.windowManager.hyprland = {
      enable = true;
      settings = {
        "$mod" = "SUPER";
        bind = [
          "$mod, RETURN, exec, ghostty"
          "$mod, B, exec, librewolf"
        ];
      };
    };
  };
}
