#!/bin/bash
set -e

cd "$( dirname "${BASH_SOURCE[0]}" )/.."

apt install chef bundler
# Ensure we have prereqs to build berkshelf
# Based on https://gist.github.com/fbrnc/8ed33626f2fdeb4507df
apt install build-essential ruby-dev git curl build-essential libxml2-dev libxslt-dev libssl-dev autoconf

# Install ruby reqs
bundle install --path vendor/bundle
bundle binstubs berkshelf


# TODO databags

scripts/update_and_run.sh
