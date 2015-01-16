# == Class: puppetdashboard
#
# Full description of class puppetdashboard here.
#
# === Parameters
#
# Document parameters here.
#
# [*sample_parameter*]
#   Explanation of what this parameter affects and what it defaults to.
#   e.g. "Specify one or more upstream ntp servers as an array."
#
# === Variables
#
# Here you should define a list of variables that this module would require.
#
# [*sample_variable*]
#   Explanation of how this variable affects the funtion of this class and if
#   it has a default. e.g. "The parameter enc_ntp_servers must be set by the
#   External Node Classifier as a comma separated list of hostnames." (Note,
#   global variables should be avoided in favor of class parameters as
#   of Puppet 2.6.)
#
# === Examples
#
#  class { 'puppetdashboard':
#    servers => [ 'pool.ntp.org', 'ntp.local.company.com' ],
#  }
#
# === Authors
#
# Sebastian Reitenbach <sebastia@l00-bugdead-prods.de>
#
# === Copyright
#
# Copyright 2014 Sebastian Reitenbach, unless otherwise noted.
#
class puppetdashboard (
  $override_general_settings = $puppetdashboard::params::general_settings,
  $override_database_settings = $puppetdashboard::params::database_settings,
  $installation_path = $puppetdashboard::params::installation_path,
  $rake = $puppetdashboard::params::rake,
  $package_name = $puppetdashboard::params::package_name,
  $package_ensure = $puppetdashboard::params::package_ensure,
  $daemon_name = $puppetdashboard::params::daemon_name,
  $daemon_ensure = $puppetdashboard::params::daemon_ensure,
  $daemon_enable = $puppetdashboard::params::daemon_enable,
  $daemon_flags = $puppetdashboard::params::daemon_flags,
  $workers_name = $puppetdashboard::params::workers_name,
  $workers_ensure = $puppetdashboard::params::workers_ensure,
  $workers_enable = $puppetdashboard::params::workers_enable,
  $workers_flags = $puppetdashboard::params::workers_flags,
) inherits puppetdashboard::params {

  class { 'puppetdashboard::install':
    package_name   => $package_name,
    package_ensure => $package_ensure,
  }

  $general_settings  = deep_merge($puppetdashboard::params::general_settings, $override_general_settings)
  $database_settings = deep_merge($puppetdashboard::params::database_settings, $override_database_settings)

  class { 'puppetdashboard::config':
    general_settings  => $general_settings,
    database_settings => $database_settings,
    installation_path => $installation_path,
  }

  class { 'puppetdashboard::service':
    daemon_name    => $daemon_name,
    daemon_ensure  => $daemon_ensure,
    daemon_enable  => $daemon_enable,
    daemon_flags   => $daemon_flags,
    workers_name   => $workers_name,
    workers_ensure => $workers_ensure,
    workers_enable => $workers_enable,
    workers_flags  => $workers_flags,
  }

  class { 'puppetdashboard::cron':
    installation_path => $installation_path,
    rake              => $rake,
  }

  Class['puppetdashboard::install'] ->
  Class['puppetdashboard::config']  ~>
  Class['puppetdashboard::service'] ->
  Class['puppetdashboard::cron']
}
