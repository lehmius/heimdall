{ config, lib, ... }:
with lib;
with lib.heimdall;
let
  cfg = config.desktops.addons.hypridle;
in
{
  options.desktops.addons.hypridle = {
    enable = mkEnableOption "Enable hypridle";
  };

  config = mkIf cfg.enable {
    services.hypridle = {
      enable = true;
      setting = {
        general = {
	  befor_sleep_cmd = "loginctl lock-session";
	  after_sleep_cmd = "hyprctl dispatch dpms on";
	  lock_cmd = "pidof hyprlock || hyprlock";
	};

	listener = [
	  {
	    timeout = 300;
	    on-timeout = "loginctl lock-session";
	  }
	  {
	    timeout = 330;
	    on-timeout = "hyprctl dispatch dpms off";
	    on-resume = "hyprctl dispatch dpms on";
	  }
	  {
	    timeout = 1800;
	    on-timeout = "systemctl suspend";
	  }
	];
      };
    };
  };
}
