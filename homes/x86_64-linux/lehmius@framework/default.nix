{ pkgs, ... }:
{
  heimdall.user {
    enable = true;
    name = "lehmius";
  };
  users.users = {
    ${config.user.name}.openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINIA9aG0+8ZEPz70m3JtpjF8xX4qHkyLqsBBOSqAicnu lehmius.github@clajus.eu"
    ];
  };

  desktops = {
    hyprland = {
      enable = true;
    };
  };

  home.packages = with pkgs; [
    neovim
    git
  ];

  suites = {
    desktop.enable = true;
  };

  home.stateVersion = "25.05";
}
