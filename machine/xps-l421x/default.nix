{ config, pkgs, ... }:

let
  sources = import ../../nix/sources.nix {};
in {
  imports = [
    "${sources.nixos-hardware}/common/pc/laptop/ssd"
    ./hardware-configuration.nix
  ];

  boot.initrd.luks.devices = {
    root = {
      device = "/dev/disk/by-uuid/88ecf1bd-2522-46ce-a4f6-0039fb2968bf";
      preLVM = true;
    };
  };

  networking.interfaces.enp7s0.useDHCP = true;
}
