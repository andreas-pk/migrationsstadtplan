class site::profile::typo3_apache_php_fpm_server (
  $fpm_pool = {},
  $vhosts = {},
  $typo3_projects = {},
  $php_inis = {},
  $php_modules = {},
  $php_modules_ini = {},
) {

  # Wir brauchen den Apache immer in kombination mit mod_status. Damit wir
  include ::apache
  include ::apache::mod::status

  # Wir benutzen PHP-FPM, deshalb müssen wir die Module leider (noch) manuell laden
  include '::php::fpm::daemon'
  apache::mod { 'proxy': }
  apache::mod { 'proxy_fcgi': }

  # Laden beliebig vieler PHP-Module
  create_resources('php::module', $php_modules)
  # Konfiguration beliebig vieler PHP-Module
  create_resources('php::module::ini', $php_modules_ini)
  # Konfiguration beliebig vieler php.ini Dateien
  create_resources('php::ini', $php_inis)
  # Konfiguration beliebig vieler php-fpm Pools
  create_resources('php::fpm::conf',$fpm_pool)
  # Konfiguration beliebig vieler VHosts
  create_resources('apache::vhost', $vhosts)
  # Konfiguration beliebig vieler typo3 Projekte
  create_resources('typo3::project', $typo3_projects)
}
