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

  $packages                    = $global::params::os_packages,
  $fact_environment            = $global::params::os_fact_environment,
  $facts                       = $global::params::facts,
  $facts_template              = $global::params::os_facts_template,

) inherits global::params {

  include stdlib

  #-----------------------------------------------------------------------------
  # Installation / Removal

  # The stdlib high level stages are (in order):
  #
  #  * setup
  #  * main
  #  * runtime
  #  * setup_infra
  #  * deploy_infra
  #  * setup_app
  #  * deploy_app
  #  * deploy

  $stages = [
    'setup',
    'main',
    'runtime',
    'setup_infra',
    'deploy_infra',
    'setup_app',
    'deploy_app',
    'deploy'
  ]

  global::stage { $stages:
    packages => $packages,
  }

  #-----------------------------------------------------------------------------
  # Configuration

  if $fact_environment and ! empty($facts) {
    file { 'fact-environment':
      path    => $fact_environment,
      content => template($facts_template),
      stage   => 'setup',
    }
  }
}

#-------------------------------------------------------------------------------

define global::stage ( $run_stage = $name, $packages = [] ) {

  $states = keys($packages[$stage])

  global::state { $states:
    packages  => $packages,
    run_stage => $run_stage,
  }
}

#-------------------------------------------------------------------------------

define global::state ( $ensure = $name, $packages = [], $run_stage = 'main' ) {

  $package_names = $packages[$run_stage][$ensure]

  if ! empty($package_names) {
    package { $package_names:
      ensure => $ensure,
      stage  => $run_stage,
    }
  }
}
