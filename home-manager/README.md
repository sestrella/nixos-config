# Home Manager config

## Getting Started

Symlink the configuration files:

```
ln -s $PWD/$USER/config.nix $config/.config/nixpkgs/config.nix
ln -s $PWD/$USER/home.nix $HOME/.config/nixpkgs/home.nix
```

Apply configuration changes:

```
home-manager switch
```
