#!/usr/bin/env bash

sudo rm -rf /etc/nixos/
sudo ln -sf $PWD/nix/ /etc/nixos

cd config/ 
for d in *; do
	echo "Made symlinks for: ${d}"
	rm -rf $HOME/.config/$d
	ln -sf $PWD/$d $HOME/.config/$d
done
cd ..

# Set ZSH env to source .zshrc config from .config instead of $HOME
echo "ZDOTDIR=$HOME/.config/zsh" > .zshenv
