#!/usr/bin/env bash


# remove exisiting files
sudo rm /etc/nixos/configuration.nix
sudo rm /etc/nixos/hardware-configuration.nix
sudo rm /etc/nixos/flake.nix
sudo rm -rf $HOME/.config/

# Create symlinks for nixos from PWD to their respective locations
sudo ln -s $PWD/nix/configuration.nix /etc/nixos/configuration.nix
sudo ln -s $PWD/nix/hardware-configuration.nix /etc/nixos/hardware-configuration.nix
sudo ln -s $PWD/nix/flake.nix /etc/nixos/flake.nix
ln -sf $PWD/config/ $HOME/.config

# Set ZSH env to source .zshrc config from .config instead of $HOME
echo "ZDOTDIR=$HOME/.config/zsh" > .zshenv
