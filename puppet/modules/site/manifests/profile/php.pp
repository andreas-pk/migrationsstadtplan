class site::profile::php (
  $php_fpm_pools= {},
  $php_inis = {},
  $php_modules = {},
) {
  include ::nginx
  include ::openssl

  # hotfix for httpd users home
  file { '/usr/share/httpd':
    ensure => "directory",
  }

  include '::php::fpm::daemon'
  # Konfiguration beliebig vieler php-fpm Pools
  create_resources('php::fpm::conf',$php_fpm_pools)

  php::ini { '/etc/php.ini':
    memory_limit   => '256M',
    cgi_fix_pathinfo => '0',
    date_timezone => 'Europe/Berlin',
    sendmail_path => '/usr/bin/env /usr/local/share/gems/gems/mailcatcher-0.6.1/bin/catchmail --smtp-port 25',
  }
  # Das hier muss eigentlich nach hiera
  #sendmail_path => '/usr/bin/env /usr/local/share/gems/gems/mailcatcher-0.6.1/bin/catchmail --smtp-port 25',

  # Konfiguration beliebig vieler php.ini Dateien
  create_resources('php::ini', $php_inis)
  php::module { 'php-mysql': }
  php::module { 'php-gd': }
  php::module { 'php-xml': }
  php::module { 'php-mbstring': }
  php::module { 'php-pecl-xdebug': }
  # Laden beliebig vieler PHP-Module
  create_resources('php::module', $php_modules)

}