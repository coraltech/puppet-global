
class global_lib::params {

  #-----------------------------------------------------------------------------
  # General configurations

  if $::hiera_exists {
    $facts                  = hiera('global_facts', $global_lib::default::facts)
    $build_essential_ensure = hiera('global_build_essential_ensure', $global_lib::default::build_essential_ensure)
    $vim_ensure             = hiera('global_vim_ensure', $global_lib::default::vim_ensure)
    $unzip_ensure           = hiera('global_unzip_ensure', $global_lib::default::unzip_ensure)
  }
  else {
    $facts                  = $global_lib::default::facts
    $build_essential_ensure = $global_lib::default::build_essential_ensure
    $vim_ensure             = $global_lib::default::vim_ensure
    $unzip_ensure           = $global_lib::default::unzip_ensure
  }

  #-----------------------------------------------------------------------------
  # Operating System specific configurations

  case $::operatingsystem {
    debian, ubuntu: {
      $os_build_essential_package = 'build-essential'
      $os_vim_package             = 'vim'
      $os_unzip_package           = 'unzip'

      $os_fact_environment        = '/etc/profile.d/facts.sh'
      $os_facts_template          = 'global_lib/facts.sh.erb'
    }
    default: {
      fail("The global_lib module is not currently supported on ${::operatingsystem}")
    }
  }
}
