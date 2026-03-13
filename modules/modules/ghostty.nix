{
  flake.modules.homeManager.ghostty = {
    programs.ghostty = {
      enable = true;
      settings = {
        theme = "Flexoki Dark";
        font-size = 14;
      };
    };
  };
}
