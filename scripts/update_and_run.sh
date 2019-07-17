#!/bin/bash
set -e

cd "$( dirname "${BASH_SOURCE[0]}" )/.."

git pull

# Prep berkshelf
BERKSHELF_PATH=$(realpath berkshelf-cache)
export BERKSHELF_PATH
! test -e Berksfile.lock || rm Berksfile.lock

berks_vendor() {
  bin/berks install
  bin/berks vendor --delete cookbooks
}

berks_vendor

BEACHHEAD_DIR=$(pwd)
export BEACHHEAD_DIR

solo_run() {
  CHEF="chef-solo"
  ! [ -e "bin/chef-solo" ] || CHEF="bin/chef-solo"
  "$CHEF" -c "${BEACHHEAD_DIR}/chef-config.rb" -j "${BEACHHEAD_DIR}/chef-attributes.json"
}

solo_run
