
class global::params {

  include global::default

  #-----------------------------------------------------------------------------
  # General configurations

  if $::hiera_ready {
    $setup_ensure     = hiera('global_setup_ensure', $global::default::setup_ensure)
    $build_ensure     = hiera('global_build_ensure', $global::default::build_ensure)
    $common_ensure    = hiera('global_common_ensure', $global::default::common_ensure)
    $runtime_ensure   = hiera('global_runtime_ensure', $global::default::runtime_ensure)
    $facts            = hiera('global_facts', $global::default::facts)
    $make_revision    = hiera('global_make_revision', $global::default::make_revision)
    $make_dev_ensure  = hiera('global_make_dev_ensure', $global::default::make_dev_ensure)
    $make_user        = hiera('global_make_user', $global::default::make_user)
    $make_group       = hiera('global_make_group', $global::default::make_group)
    $make_options     = hiera('global_make_options', $global::default::make_options)
  }
  else {
    $setup_ensure     = $global::default::setup_ensure
    $build_ensure     = $global::default::build_ensure
    $common_ensure    = $global::default::common_ensure
    $runtime_ensure   = $global::default::runtime_ensure
    $facts            = $global::default::facts
    $make_revision    = $global::default::make_revision
    $make_dev_ensure  = $global::default::make_dev_ensure
    $make_user        = $global::default::make_user
    $make_group       = $global::default::make_group
    $make_options     = $global::default::make_options
  }

  #-----------------------------------------------------------------------------
  # Operating System specific configurations

  case $::operatingsystem {
    debian, ubuntu: {
      $os_setup_packages   = []
      $os_common_packages  = [ 'vim', 'unzip', 'curl' ]
      $os_runtime_packages = []
      $os_build_packages   = [
        'build-essential',
        'libnl-dev',
        'libpopt-dev',
        'libxml2-dev',
        'libssl-dev',
        'libcurl4-openssl-dev',
      ]

      $os_fact_environment = '/etc/profile.d/facts.sh'
      $os_facts_template   = 'global/facts.sh.erb'
    }
    default: {
      fail("The global module is not currently supported on ${::operatingsystem}")
    }
  }
}
