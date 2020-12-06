# NixOS config

## Getting Started

Clone the repository:

```sh
git clone https://github.com/sestrella/nixos-config.git
```

Copy the hardware configuration:

```sh
cp /etc/nixos/hardware-configuration.nix nixos-config
```

Backup existing `nixos` directory:

```sh
sudo cp /etc/nixos /etc/nixos.backup
```

Symlink the directory:

```sh
sudo ln -s $PWD/nixos-config /etc/nixos
```

Apply the configuration changes:

```sh
sudo nixos-rebuild switch
```

## References

- [Installation of NixOS with encrypted root](https://gist.github.com/martijnvermaat/76f2e24d0239470dd71050358b4d5134)
- [Full Disk Encryption](https://nixos.wiki/wiki/Full_Disk_Encryption)
