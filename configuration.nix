# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ pkgs, ... }:

let
  epson-escpr = pkgs.epson-escpr.overrideAttrs (_: {
    version = "1.7.8";
    src = pkgs.fetchurl {
      urls = [
        "https://download3.ebz.epson.net/dsc/f/03/00/12/04/32/1a455ef8618def65700ca4e446311c2fb43cd839/epson-inkjet-printer-escpr-1.7.8-1lsb3.2.tar.gz"
        "https://web.archive.org/web/https://download3.ebz.epson.net/dsc/f/03/00/12/04/32/1a455ef8618def65700ca4e446311c2fb43cd839/epson-inkjet-printer-escpr-1.7.8-1lsb3.2.tar.gz"
      ];
      sha256 = "1pygg2bd2gh27dc65h3dzwrpvi6bq5c87wl0ldchqlc2b3blsx6p";
    };
  });
in {
  imports = [
    # Include the results of the hardware scan.
    ./machine/current
  ];

  # Use the systemd-boot EFI boot loader.
  boot.loader = {
    efi.canTouchEfiVariables = true;
    grub = {
      device = "nodev";
      efiSupport = true;
      enable = true;
      enableCryptodisk = true;
      version = 2;
    };
  };

  # networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Set your time zone.
  time.timeZone = "America/Guayaquil";

  # The global useDHCP flag is deprecated, therefore explicitly set to false here.
  # Per-interface useDHCP will be mandatory in the future, so this generated config
  # replicates the default behaviour.
  networking.useDHCP = false;

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  # console = {
  #   font = "Lat2-Terminus16";
  #   keyMap = "us";
  # };

  # Enable the GNOME 3 Desktop Environment.
  services.xserver = {
    enable = true;
    displayManager.gdm = {
      enable = true;
      wayland = false;
    };
    desktopManager.gnome3.enable = true;
  };

  # Configure keymap in X11
  # services.xserver.layout = "us";
  # services.xserver.xkbOptions = "eurosign:e";

  # Enable PostgreSQL
  services.postgresql.enable = true;
  services.redis.enable = true;

  # Enable CUPS to print documents.
  services.printing = {
    enable = true;
    drivers = [
      epson-escpr
    ];
  };

  services.avahi = {
    enable = true;
    nssmdns = true;
  };

  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio.enable = true;

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.sestrella = {
    description = "Sebastián Estrella";
    extraGroups = [
      "docker"
      "networkmanager"
      "wheel"
    ]; # Enable ‘sudo’ for the user.
    isNormalUser = true;
    shell = pkgs.fish;
  };

  security.sudo.enable = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.shells = with pkgs; [
    fish
  ];

  environment.systemPackages = with pkgs; [
    git
    vim
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  virtualisation ={
    docker.enable = true;
    virtualbox.host.enable = true;
  };

  users.extraGroups.vboxusers.members = [ "sestrella" ];

  nix.gc = {
    automatic = true;
    # config
    dates = "weekly";
    options = "--delete-older-than 5d";
  };

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "20.09"; # Did you read the comment?
}
