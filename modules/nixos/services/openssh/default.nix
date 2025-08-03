{ config, lib, ... }:
with lib;
with lib.heimdall;
let
  cfg = config.services.ssh;
in
{
  options.services.ssh = {
    enable = mkEnableOption "Enable ssh";
    authorizedKeys = mkOption {
      type = listOf str;
      default = [ ];
      description = "Public keys to apply";
    };
  };

  config = mkIf cfg.enable {
    services.openssh = {
      enable = true;
      ports = [ 22 ];
      settings = {
        PasswordAuthentication = false;
	StreamLocalBindUnlink = "yes";
	GatewayPorts = "clientspecified";
      };
    };
    users.users = {
      ${config.user.name}.openssh.authorizedKeys.keys = [
      ] // cfg.authorizedKeys;
    };
  };
}
