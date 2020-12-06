# NixOS config

## Getting Started

Clone the repository:

```
git clone https://github.com/sestrella/nixos-config.git
```

Symlink the directory:

```
sudo ln -s $PWD/nixos-config /etc/nixos
```

Apply the configuration changes:

```
sudo nixos-rebuild switch
```

## References

- [Installation of NixOS with encrypted root](https://gist.github.com/martijnvermaat/76f2e24d0239470dd71050358b4d5134)
- [Full Disk Encryption](https://nixos.wiki/wiki/Full_Disk_Encryption)
