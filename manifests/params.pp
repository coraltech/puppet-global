
class global_lib::params {

  #-----------------------------------------------------------------------------

  case $::operatingsystem {
    debian: {}
    ubuntu: {
      $build_essential_version = '11.5ubuntu2'
    }
    centos, redhat: {}
  }
}
