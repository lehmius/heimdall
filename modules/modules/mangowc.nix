{ inputs, config, ... }: {
  flake.modules.nixos.mangowc = {
    imports = [
      inputs.mangowc.nixosModules.mango
      config.flake.modules.nixos.screenshots
    ];
    programs.mango.enable = true;
  };
}
