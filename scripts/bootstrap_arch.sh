#!/bin/bash
set -e

cd "$( dirname "${BASH_SOURCE[0]}" )/.."

pacman --noconfirm --needed -S git ruby ruby-bundler base-devel

# Install ruby reqs
bundle install --path vendor/bundle
bundle binstubs berkshelf chef-bin

# TODO databags

scripts/update_and_run.sh
