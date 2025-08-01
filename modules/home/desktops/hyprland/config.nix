{ pkgs, config, lib, ... }:
with lib;
let
  cfg = config.desktops.hyprland;
in
{
  config = mkIf cfg.enable {
    wayland.windowManager.hyprland = {
      enable = true;

      systemd.enable = true;
      systemd.enableXdgAutostart = true;
      xwayland.enable = true;

      settings = {
        input = {
	  kb_layout = "colemak";
	  touchpad = { disable_while_typing = true; };
	};

	general = {
	  gaps_in = 3;
	  gaps_out = 5;
	  border_size = 2;
	};

	decoration = { rounding = 10; };

	misc = let FULLSCREEN_ONLY = 2;
	in {
	  vrr = FULLSCREEN_ONLY;
	  disable_hyprland_logo = true;
	  disable_spash_rendering = true;
	  force_default_wallpaper = 0;
	};

        # TODO: monitor configuration

	exec-once = [
	  "${pkgs.pyprland}/bin/pypr"
	] ++ cfg.execOnceExtras;
      };
    };
  };
}
