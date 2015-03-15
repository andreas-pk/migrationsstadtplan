define site::profile::php_server::site (
  $www_root = $www_root,
  $web_name = $name,
  $aliases = [$name],
  $port = '80',
  $ssl = false,
  $try_files = '$uri',
  $rewrite_rules = ['^ /index.php'],
) {
  group { "openssl": ensure => 'present' }

  openssl::certificate::x509 { "${web_name}":
    ensure       => present,
    country      => 'DE',
    organization => $web_name,
    commonname   => $web_name,
    altnames     => $aliases,
    base_dir     => '/tmp',
    group        => 'openssl',
    require      => Group['openssl']
  }
  # http://wiki.nginx.org/Drupal
  nginx::resource::vhost { "${web_name}":
    listen_port => $port,
    ssl         => $ssl,
    ssl_port    => 443,
    www_root    => "${www_root}",
    server_name => $aliases,
    group       => 'openssl',
    try_files => $try_files,
    ssl_key     => "/tmp/${web_name}.key",
    ssl_cert    => "/tmp/${web_name}.crt",
    require     => Openssl::Certificate::X509["${web_name}"],
    notify      => [Tidy["ssl-key-cert"], File["/var/lib/php/session"]]
  }

  #@todo: define more Drupal locations for better cacheing like static stuff images, css,...
  nginx::resource::location { "@rewrite":
    priority        => 402,
    vhost           => "${web_name}",
    www_root        => "${www_root}",
    ensure          => present,
    ssl             => $ssl,
    rewrite_rules => $rewrite_rules,
  }

  nginx::resource::location { "${web_root}_root":
    priority        => 403,
    vhost           => "${web_name}",
    www_root        => "${www_root}",
    ensure          => present,
    ssl             => $ssl,
    location        => '~ \.php$',
    index_files     => [ 'index.php', 'index.html', 'index.htm' ],
    proxy           => undef,
    fastcgi         => "127.0.0.1:9000",
    fastcgi_script  => undef,
    location_cfg_append => {
      fastcgi_connect_timeout => '3m',
      fastcgi_read_timeout    => '3m',
      fastcgi_send_timeout    => '3m'
    }
  }

  #@todo check why da heck it doesn't delete actually anything |-
  # ssl-key and certificate could be removed after nginx is done.
  tidy { "ssl-key-cert":
    path     => '/tmp/',
    recurse  => 1,
    age      => 0,
    backup   => false,
    matches  => ["${web_name}.*"]
  }
  #@todo fix php-fpm user (elsewhere) not to have apache here...
  file { "/var/lib/php/session": owner => 'apache', ensure => 'directory', mode => 0755 }
}
