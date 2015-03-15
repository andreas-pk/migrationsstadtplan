class site::profile::graphite_server {
  include collectd
  include collectd::plugin::syslog
  include collectd::plugin::write_graphite
  include collectd::plugin::network
  include collectd::plugin::statsd
  include collectd::plugin::cpu
  include collectd::plugin::df
  include collectd::plugin::disk
  include collectd::plugin::memory
  include collectd::plugin::processes
  include collectd::plugin::uptime
  include collectd::plugin::interface

  include graphite

  graphite::cache { 'a':}

  file { 'graphite patch':
    path=> '/opt/graphite/graphite_web.patch',
    source => 'puppet:///modules/site/graphite_web.patch',
    require => Class['graphite']
  }

  exec { 'patch graphite web':
    command => '/usr/bin/patch -p1 < graphite_web.patch',
    cwd => '/opt/graphite',
    creates => '/opt/graphite/webapp/graphite/manage.py.rej',
    returns => 1,
    require => File['graphite patch']
  }
}