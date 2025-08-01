{ config, lib, ... }:
with lib;
with lib.heimdall;
let
  cfg = config.user;
in {
  options.user = with types; {
    name = mkOption {
      type = str;
      default = "lehmius";
      description = "The name of the user's account";
    };
    initialPassword = mkOption {
      type = str;
      default = "heimdall";
      description = "The initial password of the useraccount";
    };
    extraGroups = mkOption {
      type = listOf str;
      description = "Groups beyond the default to be assigned to the user";
    };
    extraOptions = mkOption {
      type = attrsOf anything;
      description = "Extra options to be passed to users.users.<name>";
    };
  };

  config = {
    users.mutableUsers = false;
    users.users.${cfg.name} =
      {
        isNormalUser = true;
        inherit (cfg) name initialPassword;
        home = "/home/${cfg.name}";
        group = "users";

        extraGroups =
          [
            "audio"
            "sound"
            "video"
            "networkmanager"
            "input"
          ]
          ++ cfg.extraGroups;
      }
      // cfg.extraOptions;

    home-manager = {
      useGlobalPkgs = true;
      useUserPackages = true;
    };
  };
}
