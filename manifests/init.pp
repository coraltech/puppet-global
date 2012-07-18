# Class: global_lib
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
#   include global_lib
#
# [Remember: No empty lines between comments and class definition]
class global_lib (

  $os_build_essential_package = $global_lib::params::os_build_essential_package,
  $build_essential_ensure     = $global_lib::params::build_essential_ensure,
  $os_vim_package             = $global_lib::params::os_vim_package,
  $vim_ensure                 = $global_lib::params::vim_ensure,
  $os_unzip_package           = $global_lib::params::os_unzip_package,
  $unzip_ensure               = $global_lib::params::unzip_ensure,
  $os_fact_environment        = $global_lib::params::os_fact_environment,
  $facts                      = $global_lib::params::facts,
  $facts_template             = $global_lib::params::facts_template,

) inherits global_lib::params {

  $fact_environment           = $global_lib::params::os_fact_environment

  #-----------------------------------------------------------------------------
  # Installation

  if $build_essential_ensure {
    package { 'build-essential':
      name   => $global_lib::params::os_build_essential_package,
      ensure => $build_essential_ensure,
    }
  }

  if $vim_ensure {
    package { 'vim':
      name   => $global_lib::params::os_vim_package,
      ensure => $vim_ensure,
    }
  }

  if $unzip_ensure {
    package { 'unzip':
      name   => $global_lib::params::os_unzip_package,
      ensure => $unzip_ensure,
    }
  }

  #-----------------------------------------------------------------------------
  # Configuration

  if $fact_environment and ! empty($facts) {
    file { $fact_environment:
      ensure  => file,
      content => template($facts_template),
    }
  }
}
