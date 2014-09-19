class puppetdashboard::cron (
  $installation_path,
  $rake,
){
  cron { 'puppetdashboard-optimize-db':
    minute   => '0',
    hour     => '0',
    monthday => '1',
    user     => 'root',
    command  => "cd $installation_path && sudo -u _puppet-dashboard $rake RAILS_ENV=production db:raw:optimize 2>/dev/null",
  }
  cron { 'puppetdashboard-prune-reports':
    minute   => '0',
    hour     => '0',
    user     => 'root',
    command  => "cd $installation_path && sudo -u _puppet-dashboard $rake RAILS_ENV=production reports:prune upto=1 unit=mon 2>/dev/null",
  }
}
