
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

  $test_diff_cmd = "diff ${repo}/.git/_COMMIT ${repo}/.git/_COMMIT.last"

  #-----------------------------------------------------------------------------
  # Installation

  package { "${name}-dev":
    name    => $dev_packages,
    ensure  => $dev_ensure,
    require => Package['build-packages'],
  }

  #---

  git::repo { $repo:
    home      => '',
    source    => $source,
    revision  => $revision,
    user      => $user,
    group     => $group,
    require   => Package["${name}-dev"],
  }

  Exec {
    cwd  => $repo,
    user => $user,
    path => [ '/bin', '/usr/bin', '/usr/local/bin' ],
  }

  exec {
    "check-${name}":
      command   => "git rev-parse HEAD > ${repo}/.git/_COMMIT",
      require   => Class['git'],
      subscribe => Git::Repo[$repo];

    "configure-${name}":
      command   => "${repo}/configure ${options}",
      unless    => $test_diff_cmd,
      subscribe => Exec["check-${name}"];

    "make-${name}":
      command   => 'make',
      unless    => $test_diff_cmd,
      subscribe => Exec["configure-${name}"];

    "make-install-${name}":
      command   => 'make install',
      unless    => $test_diff_cmd,
      subscribe => Exec["make-${name}"];
  }

  file { "save-${name}":
    path      => "${repo}/.git/_COMMIT.last",
    source    => "${repo}/.git/_COMMIT",
    require   => Exec["check-${name}"],
    subscribe => Exec["make-install-${name}"],
  }
}
