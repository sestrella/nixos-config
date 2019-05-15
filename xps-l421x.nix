{ config, ... }:

{
  boot.initrd.luks.devices."cryptlvm" = { 
    device = "/dev/disk/by-uuid/b84e85a4-1c3a-490c-abbb-db9badab23a7";
    preLVM = true;
  };
}
