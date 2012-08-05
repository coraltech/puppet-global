
class global::params {

  include global::default

  #-----------------------------------------------------------------------------
  # General configurations

  if $::hiera_ready {
    $setup_ensure   = hiera('global_setup_ensure', $global::default::setup_ensure)
    $ensure         = hiera('global_ensure', $global::default::ensure)
    $runtime_ensure = hiera('global_runtime_ensure', $global::default::runtime_ensure)
    $build_ensure   = hiera('global_build_ensure', $global::default::build_ensure)
    $facts          = hiera('global_facts', $global::default::facts)
  }
  else {
    $setup_ensure   = $global::default::setup_ensure
    $ensure         = $global::default::ensure
    $runtime_ensure = $global::default::runtime_ensure
    $build_ensure   = $global::default::build_ensure
    $facts          = $global::default::facts
  }

  #-----------------------------------------------------------------------------
  # Operating System specific configurations

  case $::operatingsystem {
    debian, ubuntu: {
      $os_setup_packages   = []
      $os_packages         = [ 'vim', 'unzip' ]
      $os_runtime_packages = []
      $os_build_packages   = [ 'build-essential' ]

      $os_fact_environment = '/etc/profile.d/facts.sh'
      $os_facts_template   = 'global/facts.sh.erb'
    }
    default: {
      fail("The global module is not currently supported on ${::operatingsystem}")
    }
  }
}
