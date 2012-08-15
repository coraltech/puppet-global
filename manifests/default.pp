
class global::default {

  $setup_ensure     = 'present'
  $build_ensure     = 'present'
  $common_ensure    = 'present'
  $runtime_ensure   = 'present'
  $facts            = {}
  $make_revision    = 'master'
  $make_dev_ensure  = 'present'
  $make_user        = 'root'
  $make_group       = 'root'
  $make_options     = ''

  #---

  case $::operatingsystem {
    debian, ubuntu: {
      $setup_packages   = []
      $common_packages  = [ 'vim', 'unzip', 'curl' ]
      $runtime_packages = []
      $build_packages   = [
        'build-essential',
        'libnl-dev',
        'libpopt-dev',
        'libxml2-dev',
        'libssl-dev',
        'libcurl4-openssl-dev',
      ]

      $fact_environment = '/etc/profile.d/facts.sh'
      $facts_template   = 'global/facts.sh.erb'
    }
    default: {
      fail("The global module is not currently supported on ${::operatingsystem}")
    }
  }
}
