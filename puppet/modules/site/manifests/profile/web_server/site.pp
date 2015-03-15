define site::profile::web_server::site (
  $www_root,
  $web_name = $name,
  $port = '80',
  $writeable_dirs = {},
) {

  nginx::resource::vhost { "${web_name}":
    listen_port => $port,
    www_root => "${www_root}",
    index_files => [ 'index.html', 'index_dev.php', 'index.php' ],
  }

  if !empty($writeable_dirs) {
    file { $writeable_dirs:
      ensure => "directory",
      owner => "apache",
      group => "apache",
    }
  }
}
