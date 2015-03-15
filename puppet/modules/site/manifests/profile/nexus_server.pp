class site::profile::nexus_server {
  include ::nginx

  nginx::resource::vhost { 'nexus':
    ensure            => present,
    proxy             => "http://localhost:8081",
    listen_ip         => '217.66.55.70',
    client_max_body_size => '2G',
  }

  include ::java

  file { "/var/lib/nexus":
    ensure => "directory",
    before => Class[ '::nexus' ],
  }

  $nexus_dirs = [ "/var/lib/nexus/sonatype-work",
                  "/var/lib/nexus/sonatype-work/nexus/storage",
                  "/var/lib/nexus/sonatype-work/nexus/storage/releases",
                ]
  file { $nexus_dirs:
    ensure => "directory",
    owner => "nexus",
    group => "nexus",
  }

  class{ '::nexus':
    version    => '2.11.1',
    revision   => '01',
    nexus_root => '/var/lib/nexus',
    nexus_context => '/',
  }
}