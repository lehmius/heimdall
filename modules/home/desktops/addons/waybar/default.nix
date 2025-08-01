{ config, lib, ... }:
with lib;
let
  cfg = config.desktops.addons.waybar;
  commonDependencies = with pkgs; [
    coreutils
    gnugrep
    systemd
  ];
  mkScript = {
    name ? "script",
    dependencies ? [ ],
    script ? "",
  }:
  lib.getExe (
    pkgs.writeShellApplication {
      inherit name;
      text = script;
      runtimeInputs = commonDependencies ++ dependencies;
    }
  );
in
{
  options.desktops.addons.waybar = {
    enable = mkEnableOption "Enable waybar";
  };

  config = mkIf cfg.enable {
    program.waybar = {
      enable = true;
      systemd.enable = true;
      settings = [
        {
	  layer = "top";
	  position = "top";
	  margin = "0 0 0 0";
	  modules-left = [
	    "hyprland/workspaces"
	    "tray"
	  ];
	  modules-center = [
	    "hyprland/window"
	  ];
	  modules-right = [
	    "backlight"
	    #"pulseaudio"
	    "tray"
	    "clock#time"
	    "clock#date"
	  ];

	  "hyprland/workspaces" = {
	    all-outputs = false;
	    disable-scroll = true;
	    on-click = "activate";
	    show-special = true;
	  };
	  "clock#time" = {
	    interval = 1;
	    format = "{:%H:%M}";
	    tooltip = false;
	  };
	  "clock#date" = {
	    interval = 10;
	    format = "{%d}";
	    tooltip-format = "<tt><small>{calendar}</small></tt>";
	  };
	  "backlight" = {
	    tooltip = false;
	    format = "{}%";
	    interval = 5;
	    on-scroll-up = mkScript {
	      dependencies = [ pkgs.brightnessctl ];
	      script = "brightnessctl set 1%+";
	    };
	    on-scorll-down = mkScript {
	      dependencies = [ pkgs.brightnessctl ];
	      script = "brightnessctl set 1%-";
	    };
	  };
	  "tray" = {
	    spacing = 10;
	  };
	}
      ];
    };
  };
}
