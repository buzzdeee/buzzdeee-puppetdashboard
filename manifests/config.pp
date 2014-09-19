class puppetdashboard::config (
  $general_settings,
  $database_settings,
  $installation_path,
) {

  concat { "${installation_path}/config/settings.yml":
    ensure => 'present',
    owner  => '_puppet-dashboard',
    group  => '_puppet-dashboard',
    mode   => '0644',
  }

  concat { "${installation_path}/config/database.yml":
    ensure  => 'present',
    owner   => '_puppet-dashboard',
    group   => '_puppet-dashboard',
    mode    => '0644',
  }

  concat::fragment { 'puppetdashboard-settings-yml':
    target  => "${installation_path}/config/settings.yml",
    content => template('puppetdashboard/settings.yml.erb'),
    order   => '01',
  }

  $databasetype = keys($database_settings)[0]
  $dbconfig = $database_settings[$databasetype]
  concat::fragment { 'puppetdashboard-database-yml-header':
    target  => "${installation_path}/config/database.yml",
    content => template('puppetdashboard/database-header.yml.erb'),
    order   => '01',
  }
  concat::fragment { 'puppetdashboard-database-yml-contents':
    target  => "${installation_path}/config/database.yml",
    content => template('puppetdashboard/database-contents.yml.erb'),
    order   => '10',
  }
}
