{ pkgs }:

{
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

  programs.git = import ./sestrella/git.nix {};

  programs.gnome-terminal = {
    enable = true;
    showMenubar = false;
    profile = {
      "aa6992ba-8e71-468e-abc5-f758989d57b1" = {
        default = true;
        visibleName = "sestrella";
        showScrollbar = false;
        colors = {
          palette = [
            "rgb(7,54,66)"
            "rgb(220,50,47)"
            "rgb(133,153,0)"
            "rgb(181,137,0)"
            "rgb(38,139,210)"
            "rgb(211,54,130)"
            "rgb(42,161,152)"
            "rgb(238,232,213)"
            "rgb(0,43,54)"
            "rgb(203,75,22)"
            "rgb(88,110,117)"
            "rgb(101,123,131)"
            "rgb(131,148,150)"
            "rgb(108,113,196)"
            "rgb(147,161,161)"
            "rgb(253,246,227)"
          ];
          backgroundColor = "rgb(253,246,227)";
          foregroundColor = "rgb(101,123,131)";
        };
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

      noremap <C-n> :NERDTreeToggle<CR>
    '';
  };
}
