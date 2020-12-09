{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
  ];

  boot.initrd.luks.devices = {
    root = {
      device = "/dev/disk/by-uuid/235051ec-177a-405e-a6f0-754e642e57dc";
      preLVM = true;
    };
  };

  networking.interfaces.enp0s3.useDHCP = true;
}
