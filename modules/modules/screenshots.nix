{
  flake.modules.nixos.screenshots = { pkgs, ... }:
  {
    environment.systemPackages = with pkgs; [
      grim
      slurp
    ];
  };
}
