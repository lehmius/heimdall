{
  config,
  pkgs,
  lib,
  ...
}: 
let
  vimsical-nvim = pkgs.vimUtils.buildVimPlugin {
    pname = "vimsical-nvim";
    version = "2025-10-14";
    src = pkgs.fetchFromGitHub {
      owner = "lehmius";
      repo = "vimsical.nvim";
      rev = "04c14124c385ae70a0a5d05256a33cab6849274b";
      hash = "sha256-yhvKh/83vOf9c+zhNTmLbz0PtPFM5ckXAW95X1R8cq4=";
    };
  };
in {
  programs.neovim = {
    enable = true;
    plugins = with pkgs.vimPlugins; [
      vimsical-nvim
    ];
  };
}

