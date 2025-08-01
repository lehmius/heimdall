{ options, config, lib, ... }:
with lib;
with lib.heimdall; let
  cfg = config.hardware.audio;
in {
  options.hardware.audio = {
    enable = mkEnableOption "Enable hardware audio support";
  };

  config = mkIf cfg.enable {
    services.pulseaudio.enable = false;
    security.rtkit.enable = true;
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      wireplumber.enable = true;
      jack.enable = true;
      pulse.enable = true;
    };
    programs.noisetorch.enable = true;
  };
}