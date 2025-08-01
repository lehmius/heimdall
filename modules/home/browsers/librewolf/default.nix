{ config, pkgs, host, lib, ... }:
with lib;
with lib.heimdall;
let
  cfg = config.browsers.librewolf;
in
{
  options.browsers.librewolf = {
    enable = mkEnableOption "Enable the librewolf browser.";
  };

  config = mkIf cfg.enable {
    xdg.mimeApps.defaultApplications = {
      "text/html" = [ "librewolf.desktop" ];
      "text/xml" = [ "librewolf.desktop" ];
      "x-scheme-handler/http" = [ "librewolf.desktop" ];
      "x-scheme-handler/https" = [ "librewolf.desktop" ];
    };

    programs.librewolf = {
      enable = true;
      profiles.default = {
        name = "Default";

	settings = {
	};
	search = {
	  force = true;
	  default = "duck";
	  order = [
	    "duck"
	  ];
	  engines = {
	    "duck" = {
	      urls = [
	        {
		  template = "https://duckduckgo.com/search";
		  params = [
		    {
		      name = "q";
		      value = "{searchTerms}";
		    }
		  ];
		}
	      ];
	    };
	  };
	};
      };
    };
  };
}
