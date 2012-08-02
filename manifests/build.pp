
class global::build (

  $repo        = $name,
  $source      = '',
  $revision    = 'master',
  $dev_package = '',
  $dev_ensure  = 'present',

) {

  $test_install_cmd = "diff ${repo}/.git/_COMMIT ${repo}/.git/_COMMIT.last"

  #-----------------------------------------------------------------------------
  # Installation

  package { "${name}-dev":
    name   => $dev_package,
    ensure => $dev_ensure,
  }

  git::repo { $repo:
    source   => $source,
    revision => $revision,
    require  => Package["${name}-dev"],
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
