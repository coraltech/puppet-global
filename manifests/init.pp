# Class: global
#
#   This module installs misc packages and utilities that do not fit
#   neatly into specialized bundles.  It also creates and manages custom
#   Facter facts that are loaded through the user environment.
#
#   Adrian Webb <adrian.webb@coraltech.net>
#   2012-05-22
#
#   Tested platforms:
#    - Ubuntu 12.04
#
# Parameters: (see <examples/params.json> for Hiera configurations)
#
# Actions:
#
#   Installs general purpose packages and manages custom facts on the server.
#
# Requires:
#
# Sample Usage:
#
#   include global
#
# [Remember: No empty lines between comments and class definition]
class global (

  $setup_packages           = $global::params::setup_packages,
  $setup_ensure             = $global::params::setup_ensure,
  $build_packages           = $global::params::build_packages,
  $build_ensure             = $global::params::build_ensure,
  $common_packages          = $global::params::common_packages,
  $common_ensure            = $global::params::common_ensure,
  $runtime_packages         = $global::params::runtime_packages,
  $runtime_ensure           = $global::params::runtime_ensure,
  $fact_environment         = $global::params::fact_environment,
  $facts                    = $global::params::facts,
  $facts_template           = $global::params::facts_template,
  $apt_always_apt_update    = $global::params::apt_always_apt_update,
  $apt_disable_keys         = $global::params::apt_disable_keys,
  $apt_proxy_host           = $global::params::apt_proxy_host,
  $apt_proxy_port           = $global::params::apt_proxy_port,
  $apt_purge_sources_list   = $global::params::apt_purge_sources_list,
  $apt_purge_sources_list_d = $global::params::apt_purge_sources_list_d,
  $apt_purge_preferences_d  = $global::params::apt_purge_preferences_d

) inherits global::params {

  include stdlib

  #-----------------------------------------------------------------------------
  # Installation

  class { 'global::setup':
    packages                 => $setup_packages,
    ensure                   => $setup_ensure,
    apt_always_apt_update    => $apt_always_apt_update,
    apt_disable_keys         => $apt_disable_keys,
    apt_proxy_host           => $apt_proxy_host,
    apt_proxy_port           => $apt_proxy_port,
    apt_purge_sources_list   => $apt_purge_sources_list,
    apt_purge_sources_list_d => $apt_purge_sources_list_d,
    apt_purge_preferences_d  => $apt_purge_preferences_d,
    stage                    => 'setup',
  }

  if ! empty($build_packages) {
    package { 'build-packages':
      name   => $build_packages,
      ensure => $build_ensure,
    }
  }

  if ! empty($common_packages) {
    package { 'common-packages':
      name   => $common_packages,
      ensure => $common_ensure,
    }
  }

  class { 'global::runtime':
    packages => $runtime_packages,
    ensure   => $runtime_ensure,
    stage    => 'runtime',
  }

  #-----------------------------------------------------------------------------
  # Configuration

  if $fact_environment and ! empty($facts) {
    file { 'fact-environment':
      path    => $fact_environment,
      content => template($facts_template),
    }
  }
}
