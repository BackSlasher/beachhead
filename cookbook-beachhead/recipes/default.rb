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

use_systemd = node['init_package'] == 'systemd'

# TODO delete systemd units if not using it?
if use_systemd then
    systemd_unit_name = "beachhead"
    systemd_unit "#{systemd_unit_name}.service" do
      content <<~EOS
      [Unit]
      Description=Beachhead Server

      [Service]
      Type=oneshot
      ExecStart=#{beachhead_dir}/scripts/update_and_run.sh
      # Needed for Berks
      Environment=HOME=/root
      EOS
      action [:create, :enable]
    end
    systemd_unit "#{systemd_unit_name}.timer" do
      content <<~EOS
      [Unit]
      Description=Beachhead Server

      [Timer]
      OnCalendar=00/2:45

      [Install]
      WantedBy=timers.target
      EOS
      # Every 2 hours on the 0:45 minute
      # https://unix.stackexchange.com/a/396673
      action [:create, :enable, :start]
    end
else
  cron 'beachhead-runthis' do
    minute '45'
    hour '*/2'
    command "cd #{beachhead_dir} && scripts/update_and_run.sh >log/latest.log 2>&1"
  end
end
