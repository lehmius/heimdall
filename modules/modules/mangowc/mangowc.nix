{ inputs, ... }: {
  flake.modules.homeManager.mangowc = {
    imports = [ inputs.mangowc.nixosModules.mango ];
    wayland.windowManager.mango = {
      enable = true;
      home.file.".config/mango/config.conf" = ./config.conf;
      home.file.".config/mango/binds.conf" = ./binds.conf;
      autostart_sh = ''
        swaybg -i ~/pictures/wallpapers/PoE2-druid-landscape-2.png >/dev/null 2>&1 &
      '';
    };
  };
}
