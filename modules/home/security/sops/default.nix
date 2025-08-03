{ config, lib, inputs, ... }:
with lib;
with lib.heimdall;
let
  cfg = config.security.sops;
in
{
  options.security.sops = {
    enable = mkEnableOption "Enable sops secret management";
  };

  imports = with inputs; [
    sops-nix.homeManagerModules.sops
  ];

  config = mkIf cfg.enable {
    sops = {
      defaultSopsFile = ${src}/secrets.yaml;
      validateSopsFiles = false;
      age = {
	sshKeyPaths = [ "/etc/ssh/ssh_host_ed25519_key" ];
	keyFile = "/var/lib/sops-nix/key.txt";
        generateKey = true;
      };
      secrets = {
      };
    };
  };
}
