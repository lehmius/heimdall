topLevel: {
  flake.modules.homeManager.git =
  { config, ... }:
  {
    programs.git = {
      enable = true;
      ignores = [
        ".direnv/"
        "target/"
      ];
      settings = {
        user = {
          inherit (topLevel.config.flake.meta.users.${config.home.username}) name;
          inherit (topLevel.config.flake.meta.users.${config.home.username}) email;
        };
        init.defaultBranch = "master";
        url."https://github.com/".insteadOf = [
          "github:"
        ];
      };
    };
  };
}
