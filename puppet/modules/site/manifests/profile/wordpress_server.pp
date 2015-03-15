class site::profile::wordpress_server (
  # $vhost = undef,
  $docroot,
  $ssl_enable      = false,
  $bind_ip         = '127.0.0.1',
  $servername      = 'wordpress',
  $serveradmin     = 'webmaster@pixelpark.com',
  $wp_version      = undef,
  $wp_owner        = undef,
  $wp_group        = undef,
  $wp_table_prefix = undef,
  $db_user         = undef,
  $db_password     = undef,) {
  include ::apache

  class { 'wordpress':
    version         => $wp_version,
    install_dir     => $docroot,
    wp_owner        => $wp_owner,
    wp_group        => $wp_group,
    wp_table_prefix => $wp_table_prefix,
    db_user         => $db_user,
    db_password     => $db_password,
    create_db       => false,
    create_db_user  => false,
  }

  class { 'php::extension::mysql':
    package => 'php-mysql',
  }

  class { 'php::extension::gd':
    package => 'php-gd',
  }

  php::extension { 'xml':
    ensure  => "latest",
    package => "php-xml",
  }

  php::extension { 'xdebug':
    ensure  => "latest",
    package => "php-pecl-xdebug",
  }

  #  if $vhost != undef {
  #    create_resources('apache::vhost',$vhost)
  #  }

  apache::vhost { $servername:
    docroot       => $docroot,
    servername    => $servername,
    serveradmin   => $serveradmin,
    port          => 80,
    docroot_owner => $wp_owner,
    docroot_group => $wp_group,
  }

  if $ssl_enable == true {
    apache::vhost { "${servername}_ssl":
      docroot       => $docroot,
      servername    => $servername,
      serveradmin   => $serveradmin,
      port          => 443,
      docroot_owner => $wp_owner,
      docroot_group => $wp_group,
      ssl           => true,
      ssl_key       => '/etc/pki/tls/certs/wildcard.pixelpark.net-cert.pem',
      ssl_cert      => '/etc/pki/tls/private/wildcard.pixelpark.net-cert.pem',
    }
  }
}