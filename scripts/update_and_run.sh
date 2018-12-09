#!/bin/bash
set -e

cd "$( dirname "${BASH_SOURCE[0]}" )/.."

git pull

# Prep berkshelf
BERKSHELF_PATH=$(realpath berkshelf-cache)
export BERKSHELF_PATH
! test -e Berksfile.lock || rm Berksfile.lock

berks_vendor() {
  local BERKS_PATH=berks
  ! test -e bin/berks || BERKS_PATH=bin/berks
  "$BERKS_PATH" install
  "$BERKS_PATH" vendor --delete cookbooks
}

berks_vendor

BEACHHEAD_DIR=$(pwd)
export BEACHHEAD_DIR

chef-solo -c chef-config.rb -j chef-attributes.json
