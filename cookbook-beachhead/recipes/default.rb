#
# Cookbook Name:: beachhead
# Recipe:: default
#
# Copyright (C) 2017 YOUR_NAME
#
# All rights reserved - Do Not Redistribute
#

# Parse envvar
beachhead_dir = ENV['BEACHHEAD_DIR']

cron 'beachhead-runthis' do
  minute '45'
  hour '*/2'
  command "cd #{beachhead_dir} && scripts/update_and_run.sh >log/latest.log 2>&1"
end
