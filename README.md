# Beachhead

## What
Chef Solo wrapper for Ubuntu

### "Run This" script:

* Self-update (`git pull` self)
* Fetch bookbooks (Berkshelf `install`+`vendor`)
* Run Chef
  * As part of the chef-run, ensure we have a cron job to re-run this later

### Bootstrap script

* Install Chef
* Install Ruby bundle containing Brekshelf
* Run `scripts/update_and_run.sh`

## Notes

* Built to be run as root, because Chef needs to run as root.

## Quickstart 

* Clone this repo to target machine
* Customize `Berksfile.example` into `Berksfile` to install your cookbooks
* Customize `chef-attributes.json.example` to `chef-attributes.json` to change attributes and runlist
* Popuate the `databags` directory
* Run `scripts/update_and_run.sh`
* To monitor success, check out `log/latest.log`

## Advanced mode

* Fork this repo
* Remove the `# Customizable` section from `.gitignore`
* Make all of the above changes in the fork, commit
* Clone your fork to target machine
* Run `scripts/update_and_run.sh`
* Instead of manually connecting to the machine, push changes to your fork. They'll get pulled automatically.
* Occasionally update your fork with upstream's changes, if you want to

## Common scenarios

* **Temporarily disabling** - Run `sudo crontab -e` and remove/change the timing of `beachhead-runthis` job. Next the script will run (manually / automatically) it'll reconfigure the job.
* **Move repo to another dir** - Run `scripts/update_and_run.sh` again. Because of the way Chef handles cronjob, the old job will be rewritten
