# NixOS config

## Getting Started

Clone the repository:

```sh
git clone https://github.com/sestrella/nixos-config.git
```

Copy the hardware configuration:

```sh
cp /etc/nixos/hardware-configuration.nix machine/<name>/
```

Add a configuration file `default.nix`:

```nix
# machine/<name>/default.nix
{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
  ];

  boot.initrd.luks.devices = {
    root = {
      device = "/dev/disk/by-uuid/<uuid>";
      preLVM = true;
    };
  };
}
```

Symlink machine configuration:

```sh
ln -s $PWD/machine/<name> machine/current
```

Backup existing `nixos` directory:

```sh
sudo cp /etc/nixos /etc/nixos.backup
```

Symlink the directory:

```sh
sudo ln -s $PWD /etc/nixos
```

Apply the configuration changes:

```sh
sudo nixos-rebuild switch
```

## References

- [Installation of NixOS with encrypted root](https://gist.github.com/martijnvermaat/76f2e24d0239470dd71050358b4d5134)
- [Full Disk Encryption](https://nixos.wiki/wiki/Full_Disk_Encryption)
