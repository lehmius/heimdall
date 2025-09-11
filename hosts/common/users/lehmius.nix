{
  config,
  pkgs,
  inputs,
  ...
}: {
  users.users.lehmius = {
    initialHashedPassword = "$y$j9T$uXbrnTgPJ9OPjudkaCnW00$JHrgsk5OHLY92xaiE6lT2Z96LguPS6/kOH7sOLOPrk7";
    isNormalUser = true;
    description = "lehmius";
    extraGroups = [
      "wheel"
      "networkmanager"
      "libvirtd"
      "flatpak"
      "audio"
      "video"
      "input"
      "kvm"
      "qemu-libvirtd"
    ];
    openssh.authorizedKeys.keys = [
    ];
    packages = [ inputs.home-manager.packages.${pkgs.system}.default ];
  };
  home-manager.users.lehmius = 
    import ../../../home/lehmius/${config.networking.hostName}.nix;

}
