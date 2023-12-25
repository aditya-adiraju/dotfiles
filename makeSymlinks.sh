#!/usr/bin/env bash


# remove exisiting files
sudo rm /etc/nixos/configuration.nix
sudo rm /etc/nixos/hardware-configuration.nix
sudo rm /etc/nixos/flake.nix

rm $HOME/.config/Code/User/settings.json
rm -rf $HOME/.config/nvim/
rm $HOME/.zshrc

# Create symlinks for nixos from PWD to their respective locations
sudo ln -s $PWD/nix/configuration.nix /etc/nixos/configuration.nix
sudo ln -s $PWD/nix/hardware-configuration.nix /etc/nixos/hardware-configuration.nix
sudo ln -s $PWD/nix/flake.nix /etc/nixos/flake.nix
ln -s $PWD/code/settings.json $HOME/.config/Code/User/settings.json
ln -s $PWD/nvim $HOME/.config/
ln -s $PWD/zsh/.zshrc $HOME/.zshrc
