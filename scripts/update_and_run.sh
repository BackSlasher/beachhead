#!/bin/bash
set -e

cd "$( dirname "${BASH_SOURCE[0]}" )/.."

git pull

# Prep berkshelf
BERKSHELF_PATH=$(realpath berkshelf-cache)
export BERKSHELF_PATH
! test -e Berksfile.lock || rm Berksfile.lock
bin/berks install
bin/berks vendor --delete cookbooks

BEACHHEAD_DIR=$(pwd)
export BEACHHEAD_DIR

chef-solo -c chef-config.rb -j chef-attributes.json
