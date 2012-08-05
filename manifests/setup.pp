
class global::setup (

  $packages         = [],
  $ensure           = 'present',
  $fact_environment = $global::params::os_fact_environment,
  $facts            = $global::params::facts,
  $facts_template   = $global::params::os_facts_template,

) {

  #-----------------------------------------------------------------------------
  # Installation

  if ! empty($packages) {
    package { 'global-setup-packages':
      name   => $packages,
      ensure => $ensure,
    }
  }

  #-----------------------------------------------------------------------------
  # Configuration

  if $fact_environment and ! empty($facts) {
    file { 'fact-environment':
      path    => $fact_environment,
      content => template($facts_template),
    }
  }
}
