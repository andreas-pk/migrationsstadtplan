define site::profile::lemp_web_server::site (
  $www_root,
  $web_name = $name,
  $port = '80',
  $writeable_dirs = {},
) {

  nginx::resource::vhost { "${web_name}":
    listen_port => $port,
    www_root => "${www_root}",
    index_files => [ 'index_dev.php', 'index.php' ],
    try_files => [ '$uri', '@rewriteindex' ],
  }

  nginx::resource::location { "@rewriteindex":
    priority => 401,
    vhost => "${web_name}",
    ensure => present,
    www_root => "${www_root}",
    rewrite_rules => [ '^(.*)$ /index_dev.php/$1 last' ],
  }

  nginx::resource::location { "${web_root}_root":
    priority => 403,
    vhost           => "${web_name}",
    ensure          => present,
    www_root => "${www_root}",
    location        => '~ ^/(index|index_dev|upgrade)\.php(/|$)',
    fastcgi         => "127.0.0.1:9000",
    fastcgi_split_path => '^(.+\.php)(/.*)$',
    fastcgi_param => {
      'SCRIPT_FILENAME' => '$document_root$fastcgi_script_name',
      'SCRIPT_NAME' => '$fastcgi_script_name',
      'PATH_INFO' => '$fastcgi_path_info',
      'HTTPS' => 'off',
    },
    location_cfg_append => {
      fastcgi_connect_timeout => '3m',
      fastcgi_read_timeout    => '3m',
      fastcgi_send_timeout    => '3m'
    }
  }

  file { $writeable_dirs:
    ensure => "directory",
    owner => "apache",
    group => "apache",
  }
}
