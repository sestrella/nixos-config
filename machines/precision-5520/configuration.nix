{
  imports = [
    ./hardware-configuration.nix
    ../../common.nix
  ];

  boot.initrd.luks.devices."cryptlvm" = { 
    device = "/dev/disk/by-uuid/d3faf633-2f55-4b43-90f6-400c0ec062ea";
    preLVM = true;
  };

  networking.hostName = "precision-5520";
}
