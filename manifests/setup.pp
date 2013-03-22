
class global::setup (

  $packages                 = [],
  $ensure                   = 'present',
  $apt_always_apt_update    = $global::params::apt_always_apt_update,
  $apt_disable_keys         = $global::params::apt_disable_keys,
  $apt_proxy_host           = $global::params::apt_proxy_host,
  $apt_proxy_port           = $global::params::apt_proxy_port,
  $apt_purge_sources_list   = $global::params::apt_purge_sources_list,
  $apt_purge_sources_list_d = $global::params::apt_purge_sources_list_d,
  $apt_purge_preferences_d  = $global::params::apt_purge_preferences_d

) {

  #-----------------------------------------------------------------------------
  # Installation

  case $::operatingsystem {
    debian, ubuntu: {
      class { 'apt':
        always_apt_update    => $apt_always_apt_update,
        disable_keys         => $apt_disable_keys,
        proxy_host           => $apt_proxy_host,
        proxy_port           => $apt_proxy_port,
        purge_sources_list   => $apt_purge_sources_list,
        purge_sources_list_d => $apt_purge_sources_list_d,
        purge_preferences_d  => $apt_purge_preferences_d
      }
    }
  }

  if ! empty($packages) {
    package { 'global-setup-packages':
      name   => $packages,
      ensure => $ensure,
    }
    if (defined(Class['apt'])) {
      Class['apt'] -> Package['global-setup-packages']
    }
  }
}
