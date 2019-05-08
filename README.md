# NixOS config

## Getting Started

Clone the repository:

```
git clone https://github.com/sestrella/nixos-config.git
```

Symlink the configuration file:

```
sudo ln -s $PWD/configuration.nix /etc/nixos/
```

Apply configuration changes:

```
sudo nixos-rebuild switch
```
