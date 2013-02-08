
class global::setup (

  $packages = [],
  $ensure   = 'present',

) {

  #-----------------------------------------------------------------------------
  # Installation

  exec { 'update-packages':
    path    => [ '/bin', '/usr/bin' ],
    command => 'apt-get update',
    onlyif  => 'which apt-get',
  }

  if ! empty($packages) {
    package { 'global-setup-packages':
      name    => $packages,
      ensure  => $ensure,
      require => Exec['update-packages'],
    }
  }
}
