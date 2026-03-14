{ inputs, config, ... }: {
  flake.modules.nixos.mangowc = { pkgs, ... }:
  {
    imports = [
      inputs.mangowc.nixosModules.mango
      config.flake.modules.nixos.screenshots
    ];
    programs.mango = {
      enable = true;
    };
  };
}
