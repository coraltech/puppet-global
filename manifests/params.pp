
class global_lib::params {

  #-----------------------------------------------------------------------------

  case $::operatingsystem {
    debian: {}
    ubuntu: {
      $build_essential_version = '11.5ubuntu2'
      $vim_version             = '2:7.3.429-2ubuntu2'
    }
    centos, redhat: {}
  }
}
