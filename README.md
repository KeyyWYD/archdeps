# Arch-stuffs

## Dependencies

Dependencies can be installed using `setup.sh` (see "Install" section)

## Install

> Rename or remove all existing configs. Otherwise `stow` will fail to create the symlinks.

```bash
git clone https://github.com/KeyyWYD/arch-stuffs.git ~/.dotfiles
cd ~/.dotfiles && git submodule init && git submodule update --recursive

stow .

chmod +x setup.sh
./setup.sh

```
