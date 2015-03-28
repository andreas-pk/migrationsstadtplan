class site::profile::postgresql (
  $password = undef,
  $ensure = 'present',
  $dbname = undef,
  $user   = undef,
) {
  include pp_postgresql::params
  $tablespace_name = "ts_${dbname}"
  if $password == undef {
    fail('site::profile::postgresql: password darf nicht undef sein')
  }
  $data_dir        = "${pp_postgresql::params::tablespace_datadir}/${tablespace_name}"

  postgresql::server::tablespace { $tablespace_name:
    owner    => $user,
    location => $data_dir
  }

  postgresql::server::db { $dbname:
    user       => $user,
    password   => postgresql_password($user, $password),
    tablespace => $tablespace_name,
  }
}
