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
class global_lib {

  include global_lib::params

  #-----------------------------------------------------------------------------

  if $global_lib::params::build_essential_version {
    package { 'build-essential':
      ensure => $global_lib::params::build_essential_version;
    }
  }
}
