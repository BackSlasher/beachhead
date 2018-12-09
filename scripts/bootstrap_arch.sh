#!/bin/bash
set -e

cd "$( dirname "${BASH_SOURCE[0]}" )/.."

sudo pacman --noconfirm -S git
(
  YAY_DIR="$(mktemp -d)"
  cd "$YAY_DIR"
  git clone https://aur.archlinux.org/yay.git
  cd yay
  makepkg -si
)

# TODO databags

sudo scripts/update_and_run.sh
