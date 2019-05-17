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
