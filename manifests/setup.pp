
class global::setup (

  $packages = [],
  $ensure   = 'present',

) {

  #-----------------------------------------------------------------------------
  # Installation

  if ! empty($packages) {
    package { 'global-setup-packages':
      name   => $packages,
      ensure => $ensure,
    }
  }
}
