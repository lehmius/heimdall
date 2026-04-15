{
  configurations.nixos.tardis.module = {
    hardware.facter.reportPath = ./facter.json;
  };
}
