{
  flake.modules.homeManager.xdg = { pkgs, ... }:
  {
    xdg = {
      enable = true;
      # userDirs = {
      #   enable = true;
      #   createDirectories = true;
      # };
      mime.enable = true;
      # mimeApps.enable = true;
    };

    home.packages = with pkgs; [
      xdg-utils
    ];
  };
}
