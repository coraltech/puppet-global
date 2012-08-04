
class global::params {

  include global::default

  #-----------------------------------------------------------------------------
  # General configurations

  if $::hiera_ready {
    $facts = hiera('global_facts', $global::default::facts)
  }
  else {
    $facts = $global::default::facts
  }

  #-----------------------------------------------------------------------------
  # Operating System specific configurations

  case $::operatingsystem {
    debian, ubuntu: {
      $os_packages = {
        'main'   => {
          'present' => [ 'build-essential', 'vim', 'unzip' ],
        },
      }

      $os_fact_environment = '/etc/profile.d/facts.sh'
      $os_facts_template   = 'global/facts.sh.erb'
    }
    default: {
      fail("The global module is not currently supported on ${::operatingsystem}")
    }
  }
}
