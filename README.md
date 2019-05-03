# NixOS Configuration

## Getting Started

Clone the repository:

```
git clone https://github.com/sestrella/nixos-config.git
```

Link the configuration file:

```
ln -s $PWD/configuration.nix /etc/nixos/
```

Apply configuration changes:

```
nixos-rebuild switch
```
