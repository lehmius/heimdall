{ config, lib, ... }:
with lib;
with lib.heimdall;
let
  cfg = config.heimdall.user;
in
{
  options.heimdall.user = with types; {
    enable = mkEnableOption "Enable the user account.";
    home = mkOption {
      type = nullOr str;
      default = "/home/${cfg.name}";
      description = "The user's home directory";
    };
    name = mkOption {
      type = str;
      description = "The name of the user account";
    };
  };

  config = mkIf cfg.enable (mkMerge [
    {
      assertions = [
        {
	  assertion = cfg.name != null;
	  message = "heimdall.user.name must be set";
	}
      ];

      home = {
        homeDirectory = mkDefault cfg.home;
	username = mkDefault cfg.name;
      };
    }
  ]);
}
