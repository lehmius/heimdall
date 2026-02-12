{
  flake.modules.homeManager.zed-editor = { pkgs, ... }:
  {
    programs.zed-editor = {
      enable = true;
      extensions = [
        "nix"
        "toml"
        "rust"
      ];
    };
  };
}
