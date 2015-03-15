class site::profile::lemp_web_server {
  include ::nginx
  include ::remi

  class { 'php::fpm':
    ensure => 'latest',
    package => 'php-fpm',
    service_name => 'php-fpm',
    inifile => '/etc/php-fpm.conf',
  }

  php::config { 'Fix pathinfo':
    setting => 'cgi.fix_pathinfo',
    value => '0',
    file => '/etc/php.ini',
    section => 'PHP',
  }
  php::config { 'Set Timezone':
    setting => 'date.timezone',
    value => 'Europe/Berlin',
    file => '/etc/php.ini',
    section => 'Date',
  }

  class { 'php::extension::mysql':
    package => 'php-mysql',
  }
  class { 'php::extension::gd':
    package => 'php-gd',
  }
  class { 'php::extension::intl':
    package => 'php-intl',
  }
  php::extension { 'xml':
    ensure   => "latest",
    package  => "php-xml",
  }
  php::extension { 'mbstring':
    ensure   => "latest",
    package  => "php-mbstring",
  }
}
