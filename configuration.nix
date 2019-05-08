# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

let
  homeManager = import (fetchTarball {
    url = "https://github.com/rycee/home-manager/archive/release-19.03.tar.gz";
    sha256 = "1pyxf611p1h1v30j3d337v2ng7qsajmkm6dsbrjzz466wjsp2ln4";
  }) {};
in {
  imports =
    [ # Include the results of the hardware scan.
      /etc/nixos/hardware-configuration.nix
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.initrd.luks.devices = [
    {
      name = "cryptlvm";
      device = "/dev/disk/by-uuid/d3faf633-2f55-4b43-90f6-400c0ec062ea";
      preLVM = true;
    }
  ];

  # networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  # i18n = {
  #   consoleFont = "Lat2-Terminus16";
  #   consoleKeyMap = "us";
  #   defaultLocale = "en_US.UTF-8";
  # };

  # Set your time zone.
  time.timeZone = "America/Guayaquil";

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = [
    homeManager.home-manager
    pkgs.hwinfo
    pkgs.pciutils
    pkgs.vim
  ];

  # Virtualization
  virtualisation.virtualbox.host.enable = true;

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = { enable = true; enableSSHSupport = true; };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Enable CUPS to print documents.
  services.printing = {
    enable = true;
    drivers = with pkgs; [ hplip ];
  };

  # Enable sound.
  # sound.enable = true;
  # hardware.pulseaudio.enable = true;

  # Enable the X11 windowing system.
  services.xserver.enable = true;
  # services.xserver.layout = "us";
  # services.xserver.xkbOptions = "eurosign:e";

  # Enable touchpad support.
  services.xserver.libinput.enable = true;

  # Enable the Gnome Desktop Environment.
  services.xserver.displayManager.gdm = {
    enable = true;
    wayland = false;
  };
  services.xserver.desktopManager.gnome3.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.sestrella = {
    description = "Sebastián Estrella";
    isNormalUser = true;
    extraGroups = [
      "networkmanager"
      "vboxusers"
      "wheel"
    ]; # Enable ‘sudo’ for the user.
    shell = pkgs.fish;
  };

  # sudoers
  security.sudo.extraRules = [{
    users = [ "sestrella" ];
    commands = [{
      command = "/run/current-system/sw/bin/nixos-rebuild switch";
      options = [ "NOPASSWD" ];
    }];
  }];

  # This value determines the NixOS release with which your system is to be
  # compatible, in order to avoid breaking some software such as database
  # servers. You should change this only after NixOS release notes say you
  # should.
  system.stateVersion = "19.03"; # Did you read the comment?

}
