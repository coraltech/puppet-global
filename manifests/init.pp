#
# Class: global_lib
#
# This module installs misc global packages and utilities that do not fit neatly
# into specialized bundles.
#
# Parameters:
#
# None
#
# Actions:
#
# 1. Installs global general purpose packages on the server.
#
# Requires:
#
# None
#
# Sample Usage:
#
# include global_lib
#
class global_lib {

  include global_lib::params

  #-----------------------------------------------------------------------------

  package {
    'build-essential':
      ensure => $global_lib::params::build_essential_version;
  }
}
