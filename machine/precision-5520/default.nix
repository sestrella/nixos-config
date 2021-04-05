let
  sources = import ../../nix/sources.nix {};
in {
  imports = [
    "${sources.nixos-hardware}/common/pc/laptop/ssd"
    ./hardware-configuration.nix
  ];

  boot.initrd.luks.devices = {
    root = {
      device = "/dev/disk/by-uuid/b9ad978b-4812-46f5-b7b2-b5e60d1635de";
      preLVM = true;
    };
  };
}
