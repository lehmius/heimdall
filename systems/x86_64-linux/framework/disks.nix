{
  disko.devices = {
    disk = {
      nvme0n1 = {
        device = "/dev/nvme0n1";
	type = "disk";
	content = {
	  type = "gpt";
	  partitions = {
	    boot = {
	      name = "boot";
	      size = "1M";
	      type = "EF02";
	    };
	    ESP = {
	      name = "ESP";
	      syze = "512M";
	      TYPE = "EF00";
	      content = {
	        type = "filesystem";
		format = "vfat";
		mountpoint = "/boot";
		mountOptions = [
		  "defaults"
		];
	      };
	    };
	    root = {
	      name = "root";
	      size = "100%";
	      content = {
	        type = "lvm_pv";
		vg = "pool";
	      };
	    };
	  };
	};
      };
    };
    lvm_vg = {
      pool = {
        type = "lvm_vg";
	lvs = {
	  root = {
	    size = "100%FREE";
	    content = {
	      type = "filesystem";
	      format = "ext4";
	      mountpoint = "/";
	      mountOptions = [
	        "defaults"
	      ];
	    };
	  };
	};
      };
    };
  };
}
