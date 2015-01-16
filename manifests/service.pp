# Private class, do not use directly.
# Takes care about the services.

class puppetdashboard::service (
  $daemon_name,
  $daemon_ensure,
  $daemon_enable,
  $daemon_flags,
  $workers_name,
  $workers_ensure,
  $workers_enable,
  $workers_flags,
) {
  service { $daemon_name:
    ensure => $daemon_ensure,
    enable => $daemon_enable,
    flags  => $daemon_flags,
  }
  service { $workers_name:
    ensure => $workers_ensure,
    enable => $workers_enable,
    flags  => $workers_flags,
  }
}
