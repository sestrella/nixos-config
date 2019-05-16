# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ pkgs, ... }:

let
  home-manager = builtins.fetchTarball {
    url = "https://github.com/rycee/home-manager/archive/release-19.03.tar.gz";
    sha256 = "1y4d57girr6v2g2dc7av38s2fbc19haid2405z310rqyv8qai9wy";
  };
in {
  imports = [
    "${home-manager}/nixos"
  ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

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
  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    git
    hwinfo
    pciutils
    vim
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
  services.avahi.enable = true;

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

  home-manager.users.sestrella = {
    home.packages = [
      pkgs.docker
      pkgs.ffmpeg
      pkgs.google-chrome
      pkgs.ripgrep
      pkgs.slack
      pkgs.spotify
      pkgs.vagrant
    ];

    programs.bat = {
      enable = true;
      config = {
        theme = "GitHub";
      };
    };

    programs.fish = {
      enable = true;
      shellAliases = {
        cat = "bat";
      };
      shellAbbrs = {
        # git
        ga = "git add";
        gaa = "git add --all";
        gbr = "git branch";
        gc = "git commit -v";
        gco = "git checkout";
        gd = "git diff";
        gl = "git pull";
        gp = "git push";
        gst = "git status";
        # tmux
        ta = "tmux attach-session -t";
        tkss = "tmux kill-session -t";
        tksv = "tmux kill-server";
        tl = "tmux list-sessions";
        ts = "tmux new-session -s";
      };
    };

    programs.git = {
      enable = true;
      userEmail = "sestrella.me@gmail.com";
      userName = "Sebastián Estrella";
      aliases = {
        br = "branch";
        ci = "commit";
        co = "checkout";
        st = "status";
      };
      extraConfig = {
        core = {
          editor = "vim";
        };
      };
    };

    programs.gnome-terminal = {
      enable = true;
      showMenubar = false;
      profile = {
        "aa6992ba-8e71-468e-abc5-f758989d57b1" = {
          default = true;
          visibleName = "sestrella";
          showScrollbar = false;
        };
      };
    };

    programs.tmux = {
      enable = true;
      shortcut = "a";
      baseIndex = 1;
      terminal = "screen-256color";
    };

    programs.vim = {
      enable = true;
      plugins = [
        "ctrlp"
        "nerdtree"
        "typescript-vim"
        "vim-nix"
      ];
      settings = {
        expandtab = true;
        ignorecase = true;
        number = true;
        smartcase = true;
      };
      extraConfig = ''
        let g:ctrlp_user_command = '${pkgs.ripgrep}/bin/rg %s --files --color=never --glob ""'
        let g:ctrlp_use_caching = 0
      '';
    };
  };

  # This value determines the NixOS release with which your system is to be
  # compatible, in order to avoid breaking some software such as database
  # servers. You should change this only after NixOS release notes say you
  # should.
  system.stateVersion = "19.03"; # Did you read the comment?
}
