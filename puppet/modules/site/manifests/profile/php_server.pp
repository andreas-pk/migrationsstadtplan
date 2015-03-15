class site::profile::php_server {
  include ::nginx
  include ::openssl

  #cgi.fix_pathinfo=0
  #date.timezone = "Europe/Berlin"
  class { 'php::fpm':
    ensure => 'latest',
    package => 'php-fpm',
    service_name => 'php-fpm',
    inifile => '/etc/php-fpm.conf',
  }

  class { 'php::extension::mysql':
    package => 'php-mysql',
  }
  class { 'php::extension::gd':
    package => 'php-gd',
  }
  php::extension { 'xml':
    ensure   => "latest",
    package  => "php-xml",
  }
  php::extension { 'mbstring':
    ensure   => "latest",
    package  => "php-mbstring",
  }
  php::extension { 'xdebug':
    ensure   => "latest",
    package  => "php-pecl-xdebug",
  }
}