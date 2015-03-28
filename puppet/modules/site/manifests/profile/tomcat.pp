class site::profile::tomcat (
  $app_name                  = undef,
  $home                      = undef,
  $webapps_dir               = undef,
  $bind_host                 = undef,
  $bind_port                 = 8080,
  $site_name                 = undef,
  $jmx_enabled               = false,
  $jmx_ip                    = undef,
  $jmx_authenticate          = undef,
  $jmx_ssl                   = undef,
  $jmx_registry_port         = undef,
  $jmx_server_port           = undef,
  $shutdown_port             = undef,
  $version_conf_opts         = [],
  $log4j_properties          = {},
  $enable_cluster            = false,
  $channel_send_options      = undef,
  $multicast_ip              = undef,
  $multicast_port            = undef,
  $multicast_frequency       = undef,
  $multicast_droptime        = undef,
  $receiver_ip               = undef,
  $receiver_port             = undef,
  $receiver_autobind         = undef,
  $receiver_selector_timeout = undef,
  $receiver_max_threads      = undef,
  $jvm_route                 = undef,
) {
  validate_string($bind_host)
  validate_hash($log4j_properties)

  tomcat2::instance { $app_name:
    default_host      => $site_name,
    shutdown_port     => $shutdown_port,
    jmx_enabled       => $jmx_enabled,
    jmx_authenticate  => $jmx_authenticate,
    jmx_ssl           => $jmx_ssl,
    jmx_registry_port => $jmx_registry_port,
    jmx_server_port   => $jmx_server_port,
    jmx_ip            => $jmx_ip,
    manage_web_xml    => true,
    version_conf_opts => $version_conf_opts,
    jvm_route         => $jvm_route
  }

  if $enable_cluster {
    tomcat2::cluster::simple { $app_name:
      channel_send_options      => $channel_send_options,
      multicast_ip              => $multicast_ip,
      multicast_port            => $multicast_port,
      multicast_frequency       => $multicast_frequency,
      multicast_droptime        => $multicast_droptime,
      receiver_ip               => $receiver_ip,
      receiver_port             => $receiver_port,
      receiver_autobind         => $receiver_autobind,
      receiver_selector_timeout => $receiver_selector_timeout,
      receiver_max_threads      => $receiver_max_threads,
    }
  }

  tomcat2::connector::ajp { $app_name:
    address => $bind_host,
    port    => $bind_port
  }

  tomcat2::host { $app_name:
    appbase           => $webapps_dir,
    host_name         => 'localhost',
    deploy_on_startup => true,
  }

  #  tomcat2::context { 'ROOT':
  #    instance  => 'confluence',
  #    host_name => 'localhost',
  #    content   => template('liferay/context.xml.erb')
  #  }

  tomcat2::realm::userdatabase { $app_name: }

  file { $webapps_dir:
    ensure  => directory,
    owner   => $app_name,
    group   => $app_name,
    require => User[$app_name]
  }

  file { $home:
    ensure  => directory,
    owner   => $app_name,
    group   => $app_name,
    require => User[$app_name]
  }
}
