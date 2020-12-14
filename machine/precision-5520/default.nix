{ ... }:

let
  sources = import ../../nix/sources.nix {};
in {
  imports = [
    "${sources.nixos-hardware}/common/pc/laptop/ssd"
    ./hardware-configuration.nix
  ];

  boot.initrd.luks.devices = {
    root = {
      device = "/dev/disk/by-uuid/73c1cbdf-b008-43ee-872a-2fc6d0ba3050";
      preLVM = true;
    };
  };
}
