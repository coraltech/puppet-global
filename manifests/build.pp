
define global::build (

  $repo           = $name,
  $source         = '',
  $revision       = 'master',
  $dev_packages   = [],
  $dev_ensure     = 'present',
  $build_packages = $global::params::os_build_packages,
  $build_ensure   = $global::params::build_ensure,

) {

  include git

  $test_install_cmd = "diff ${repo}/.git/_COMMIT ${repo}/.git/_COMMIT.last"

  #-----------------------------------------------------------------------------
  # Installation

  if ! defined(Class['global::build::setup']) {
    class { 'global::build::setup':
      packages => $build_packages,
      ensure   => $build_ensure,
    }
  }

  package { "${name}-dev":
    name    => $dev_packages,
    ensure  => $dev_ensure,
    require => Class['global::build::setup'],
  }

  #---

  git::repo { $repo:
    source    => $source,
    revision  => $revision,
    require   => Package["${name}-dev"],
  }

  Exec {
    cwd  => $repo,
    path => [ '/bin', '/usr/bin', '/usr/local/bin' ],
  }

  exec {
    "check-${name}":
      command   => "git rev-parse HEAD > ${repo}/.git/_COMMIT",
      require   => Class['git'],
      subscribe => Git::Repo[$repo];

    "configure-${name}":
      command   => './configure',
      unless    => $test_install_cmd,
      subscribe => Exec["check-${name}"];

    "make-${name}":
      command   => 'make',
      unless    => $test_install_cmd,
      subscribe => Exec["configure-${name}"];

    "make-install-${name}":
      command   => 'make install',
      unless    => $test_install_cmd,
      subscribe => Exec["make-${name}"];
  }

  file { "save-${name}":
    path      => "${repo}/.git/_COMMIT.last",
    source    => "${repo}/.git/_COMMIT",
    subscribe => Exec["make-install-${name}"],
  }
}

#-------------------------------------------------------------------------------
# Internal build setup class

class global::build::setup (

  $packages = [],
  $ensure   = 'present',

) {

  #-----------------------------------------------------------------------------
  # Installation

  if ! empty($packages) {
    package { 'global-build-packages':
      name   => $packages,
      ensure => $ensure,
    }
  }
}
