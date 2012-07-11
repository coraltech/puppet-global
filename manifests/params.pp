
class global_lib::params {

  #-----------------------------------------------------------------------------

  case $::operatingsystem {
    debian: {}
    ubuntu: {
      $build_essential_package = 'build-essential'
      $build_essential_version = '11.5ubuntu2'

      $vim_package             = 'vim'
      $vim_version             = '2:7.3.429-2ubuntu2'

      $unzip_package           = 'unzip'
      $unzip_version           = '6.0-4ubuntu1'
    }
    centos, redhat: {}
  }
}
