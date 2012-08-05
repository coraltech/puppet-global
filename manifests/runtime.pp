
class global::runtime (

  $packages = [],
  $ensure   = 'present',

) {

  #-----------------------------------------------------------------------------
  # Installation

  if ! empty($packages) {
    package { 'global-runtime-packages':
      name   => $packages,
      ensure => $ensure,
    }
  }
}
