
define global::make (

  $repo         = $name,
  $source       = '',
  $revision     = $global::params::make_revision,
  $dev_packages = [],
  $dev_ensure   = $global::params::make_dev_ensure,
  $user         = $global::params::make_user,
  $group        = $global::params::make_group,
  $options      = $global::params::make_options,

) {

  include git

  #-----------------------------------------------------------------------------
  # Installation

  package { "${name}-dev":
    name    => $dev_packages,
    ensure  => $dev_ensure,
    require => Package['build-packages'],
  }

  #---

  git::repo { $repo:
    home          => '',
    source        => $source,
    revision      => $revision,
    user          => $user,
    group         => $group,
    require       => Package["${name}-dev"],
    update_notify => Exec["configure-${name}"],
  }

  Exec {
    cwd  => $repo,
    user => $user,
    path => [ '/bin', '/usr/bin', '/usr/local/bin' ],
  }

  exec {
    "configure-${name}":
      command     => "${repo}/configure ${options}",
      refreshonly => true;

    "make-${name}":
      command     => 'make',
      refreshonly => true,
      subscribe   => Exec["configure-${name}"];

    "make-install-${name}":
      command     => 'make install',
      refreshonly => true,
      subscribe   => Exec["make-${name}"];
  }
}
