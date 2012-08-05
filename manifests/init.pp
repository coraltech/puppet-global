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

  $setup_packages              = $global::params::os_setup_packages,
  $setup_ensure                = $global::params::setup_ensure,
  $packages                    = $global::params::os_packages,
  $ensure                      = $global::params::ensure,
  $runtime_packages            = $global::params::os_runtime_packages,
  $runtime_ensure              = $global::params::runtime_ensure,
  $fact_environment            = $global::params::os_fact_environment,
  $facts                       = $global::params::facts,
  $facts_template              = $global::params::os_facts_template,

) inherits global::params {

  include stdlib

  #-----------------------------------------------------------------------------
  # Installation

  class { 'global::setup':
    packages         => $setup_packages,
    ensure           => $setup_ensure,
    fact_environment => $fact_environment,
    facts            => $facts,
    facts_template   => $facts_template,
    stage            => 'setup',
  }

  if ! empty($packages) {
    package { $packages:
      ensure => $ensure,
    }
  }

  class { 'global::runtime':
    packages => $runtime_packages,
    ensure   => $runtime_ensure,
    stage    => 'runtime',
  }
}
