{ pkgs, config, lib, ... }:
with lib;
let
  cfg = config.desktops.hyprland;
in
{
  config = mkIf cfg.enable {
    wayland.windowManager.hyprland.settings = {
      bind = let
        workspaces = [ "0" "1" "2" "3" "4" "5" "6" "7" "8" "9" ];
	directions = rec {
	  left = "l"; right = "r";
	  up = "u"; down = "d";
	  h = left; l = right;
	  k = up; j = down;
        }; 
	terminal = config.home.sessionVariables.TERM;
	editor = config.home.sessionVariables.EDITOR;
	filemanager = config.home.sessionVariable.FILEMANAGER;
      in lib.flatten [
        "ALT, space, exec, rofi -show drun"
	"ALT, Return, exec, ${terminal}"
	"CTRL_ALT, v, exec, ${terminal} ${editor}"
	"CTRL_ALT, f, exec, ${filemanager}"

	"SHIFTALT, q, killactive"

	"ALT, f, fullsceenstate, 2 -1" # fullsceen current window
	"SHIFTALT, F, togglefloating"
	"SHIFTALT, P, pin, active" # pin current window (i.e. show in all wps)

	# Move window to workspace
	(map (n: "SHIFTALT, ${n}, movetoworkspace, name: ${n}") workspaces)

	# Move focus from active window to window in specified direction
	(lib.mapAttrsToList (key: direction: "ALT,${key},movefocus,${direction},warp") directions)

	# Move focused window in specified direction
	(lib.mapAttrsToList (key: direction: "SHIFTALT,${key},movewindow,${direction}") directions)

	# Move workspace to monitor in specified direction
	(lib.mapAttrsToList (key: direction:
	  "CTRLSHIFT, ${key}, movecurrentworkspacetomonitor, ${direction}"
	) directions)

	"SHIFTALT, r, exec, hyprctl reload"
	"SUPER, l, exec hyprlock"
	"SUPERSHIFT, M, exit"

      ];
    };
  };
}
