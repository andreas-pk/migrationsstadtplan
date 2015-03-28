define site::profile::drupal_web_server::site (
  $www_root,
  $web_name = $name,
  $aliases = [$name],
  $port = '80',
  $drupal_version = '7',
  $ssl = false,
) {

  # http://wiki.nginx.org/Drupal
  $rewrite_rules = $drupal_version ? {
    6 => [ '^/(.*)$ /index.php?q=$1' ],
    7 => ['^ /index.php'],
  }

  ::site::profile::php::site {$name:
    www_root => $www_root,
    web_name => $web_name,
    aliases => $aliases,
    port => $port,
    ssl => $ssl,
    rewrite_rules => $rewrite_rules,
    try_files => [ '$uri @rewrite' ],
  }
}
