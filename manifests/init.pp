# Class: global_lib
#
#   This module installs misc packages and utilities that do not fit
#   neatly into specialized bundles.  It also creates and manages custom
#   Facter facts that are loaded through the user environment.
#
#   Adrian Webb <adrian.webb@coraltg.com>
#   2012-05-22
#
#   Tested platforms:
#    - Ubuntu 12.04
#
# Parameters:
#
#  $facts                   = $global_lib::params::facts,
#  $build_essential_version = $global_lib::params::build_essential_version,
#  $vim_version             = $global_lib::params::vim_version,
#  $unzip_version           = $global_lib::params::unzip_version,
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

  $facts                   = $global_lib::params::facts,
  $build_essential_version = $global_lib::params::build_essential_version,
  $vim_version             = $global_lib::params::vim_version,
  $unzip_version           = $global_lib::params::unzip_version,

) inherits global_lib::params {

  $fact_environment        = $global_lib::params::fact_environment

  #-----------------------------------------------------------------------------
  # Installation

  if $build_essential_version {
    package { 'build-essential':
      name   => $global_lib::params::build_essential_package,
      ensure => $build_essential_version,
    }
  }

  if $vim_version {
    package { 'vim':
      name   => $global_lib::params::vim_package,
      ensure => $vim_version,
    }
  }

  if $unzip_version {
    package { 'unzip':
      name   => $global_lib::params::unzip_package,
      ensure => $unzip_version,
    }
  }

  #-----------------------------------------------------------------------------
  # Configuration

  if $fact_environment and ! empty($facts) {
    file { $fact_environment:
      ensure  => 'file',
      content => template('global_lib/facts.sh.erb'),
    }
  }
}
