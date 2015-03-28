class site::profile::apache (
  $host_servername   = undef,
  $bind_host         = $::ipaddress,
  $proxy_host        = $::fqdn,
  $proxy_port        = 8080,
  $ssl               = false,
  $ssl_cert          = undef,
  $ssl_key           = undef,
  $ssl_ca            = undef,
  $directories       = undef,
  $custom_log_format = undef,
  $enable_logstash   = undef,
  $headers           = undef,
  $request_headers   = undef,
) {
  httpd::vhost { "${$host_servername}_http":
    host_servername   => $host_servername,
    ip                => $bind_host,
    port              => 80,
    docroot           => "/www/sites/${host_servername}/docs",
    redirect_status   => 'permanent',
    redirect_dest     => "https://${host_servername}/",
    directories       => $directories,
    custom_log_format => $custom_log_format,
    enable_logstash   => $enable_logstash,
    headers           => $headers,
    request_headers   => $request_headers,
  }

  httpd::vhost { "${$host_servername}_http_ssl":
    host_servername   => $host_servername,
    ip                => $bind_host,
    port              => 443,
    docroot           => "/www/sites/${host_servername}/docs",
    proxy_pass        => [{
        'path' => '/',
        'url'  => "ajp://${$proxy_host}:${$proxy_port}/"
      }
      ,],
    ssl               => $ssl,
    ssl_cert          => $ssl_cert,
    ssl_key           => $ssl_key,
    ssl_ca            => $ssl_ca,
    directories       => $directories,
    custom_log_format => $custom_log_format,
    enable_logstash   => $enable_logstash,
    headers           => $headers,
    request_headers   => $request_headers,
  }
}
