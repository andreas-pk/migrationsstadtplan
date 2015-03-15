define site::profile::typo3_web_server::site (
  $www_root,
  $web_name = $name,
  $aliases = [$name],
  $port = '80',
  $ssl = false,
) {

  site::profile::php_server::site {$name:
    www_root => $www_root,
    web_name => $web_name,
    aliases => $aliases,
    port => $port,
    ssl => $ssl,
    rewrite_rules => $rewrite_rules,
    try_files => [ '$uri $uri/ index.php @rewrite' ],
  }
}
