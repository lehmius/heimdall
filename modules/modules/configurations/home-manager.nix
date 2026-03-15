{ lib, config, ... }:
{
  options.configurations.homeManager = lib.mkOption {
    type = lib.types.lazyAttrsOf (
      lib.types.submodule {
        options.module = lib.mkOption {
          type = lib.types.deferredModule;
        };
      }
    );
  };

  config.flake.modules.homeManager = lib.flip lib.mapAttrs config.configurations.homeManager (
    name: { module }: { imports = [ module ]; }
  );
}
