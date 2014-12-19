class puppetdashboard::params {
  $general_settings = {
    cn_name                          => 'dashboard',
    ca_crl_path                      => 'certs/dashboard.ca_crl.pem',
    ca_certificate_path              => 'certs/dashboard.ca_cert.pem',
    certificate_path                 => 'certs/dashboard.cert.pem',
    private_key_path                 => 'certs/dashboard.private_key.pem',
    public_key_path                  => 'certs/dashboard.public_key.pem',
    ca_server                        => 'puppet',
    ca_port                          => 8140,
    key_length                       => 1024,
    enable_inventory_service         => false,
    inventory_server                 => 'puppet',
    inventory_port                   => 8140,
    use_file_bucket_diffs            => false,
    file_bucket_server               => 'puppet',
    file_bucket_port                 => 8140,
    no_longer_reporting_cutoff       => 3600,
    daily_run_history_length         => 30,
    use_external_node_classification => true,
    datetime_format                  => '%Y-%m-%d %H:%M %Z',
    date_format                      => '%A, %B %e, %Y',
    custom_logo_url                  => '/images/dashboard_logo.png',
    custom_logo_width                => '155px',
    custom_logo_height               => '23px',
    custom_logo_alt_text             => 'Puppet Dashboard',
    disable_legacy_report_upload_url => false,
    enable_read_only_mode            => false,
    nodes_per_page                   => 20,
    classes_per_page                 => 50,
    groups_per_page                  => 50,
    reports_per_page                 => 20,
    radiator_refresh_rate            => 60,
    application_refresh_rate         => 5,        
  }
  $database_settings = {
    'production' => {
       host     => 'localhost',
       adapter  => 'mysql',
       database => 'dashboard_production',
       username => 'dashboard',
       password => 'dashboard',
       encoding => 'utf8',
    }
  }
  $installation_path = '/var/www/puppet-dashboard'
  $rake              = '/usr/local/bin/rake18'
  $package_name = 'puppet-dashboard'
  $package_ensure = 'installed'
  $daemon_name = 'puppet_dashboard'
  $daemon_ensure = 'running'
  $daemon_enable = true
  $daemon_flags = '-e production'
  $workers_name = 'puppet_dashboard_workers'
  $workers_ensure = 'running'
  $workers_enable = true
  $workers_flags = '-p dashboard -n 4 -m'
}
