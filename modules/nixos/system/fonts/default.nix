{ options, config, pkgs, lib, ... }:
with lib;
with lib.heimdall; 
let
  cfg = config.system.fonts;
in {
  options.system.fonts = with types; {
    enable = mkEnableOption "Whether or not to manage fonts.";
    fonts = mkOption {
      type = listOf package;
      description = "Custom font packages to install."
    };
  };

  config = mkIf cfg.enable {
    environment.variables = {
      # Enable icons in tooling since we have nerdfonts.
      LOG_ICONS = "true";
    };

    environment.systemPackages = with pkgs; [font-manager];

    fonts.packages = with pkgs;
      [
        noto-fonts
        noto-fonts-cjk-sans
        noto-fonts-cjk-serif
        noto-fonts-emoji
        (nerdfonts.override {fonts = ["JetBrainsMono"];})
      ]
      ++ cfg.fonts;
  };
}