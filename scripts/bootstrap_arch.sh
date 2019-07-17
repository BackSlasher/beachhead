#!/bin/bash
set -e

cd "$( dirname "${BASH_SOURCE[0]}" )/.."

sudo pacman --noconfirm -S git ruby
sudo gem install bundler

# Install ruby reqs
bundle install --path vendor/bundle
bundle binstubs berkshelf

# TODO databags

sudo scripts/update_and_run.sh
