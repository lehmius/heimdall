{ config, ... }:
{
  config.flake.modules.homeManager.brave = { pkgs, ... }:
  {

    programs.chromium = {
      enable = true;
      package = pkgs.brave;
      commandLineArgs = [];
      extensions = [
        { id = "nngceckbapebfimnlniiiahkandclblb"; } # bitwarden
        { id = "eimadpbcbfnmbkopoojfekhnkhdbieeh"; } # dark reader
        { id = "edibdbjcniadpccecjdfdjjppcpchdlm"; } # I still don't care about cookies
        { id = "cjpalhdlnbpafiamejdnhcphjbkeiagm"; } # uBlock Origin
      ];
    };
  };
}
