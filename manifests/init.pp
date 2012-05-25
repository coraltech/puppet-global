# Class: global_lib
#
#   This module installs misc packages and utilities that do not fit
#   neatly into specialized bundles.
#
#   Adrian Webb <adrian.webb@coraltg.com>
#   2012-05-22
#
#   Tested platforms:
#    - Ubuntu 12.04
#
# Parameters:
#
#   $build_essential_version = $global_lib::params::build_essential_version,
#   $vim_version             = $global_lib::params::vim_version
#
# Actions:
#
#   Installs general purpose packages on the server.
#
# Requires:
#
# Sample Usage:
#
#   include global_lib
#
# [Remember: No empty lines between comments and class definition]
class global_lib (

  $build_essential_version = $global_lib::params::build_essential_version,
  $vim_version             = $global_lib::params::vim_version
)
inherits global_lib::params {

  #-----------------------------------------------------------------------------

  if $build_essential_version {
    package { 'build-essential':
      ensure => $build_essential_version,
    }
  }

  if $vim_version {
    package { 'vim':
      ensure => $vim_version,
    }
  }
}
