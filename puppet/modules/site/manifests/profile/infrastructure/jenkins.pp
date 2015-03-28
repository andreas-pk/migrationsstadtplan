class site::profile::infrastructure::jenkins (
  $jobs = {},
  $users = {}
) {
  include ::nginx

  nginx::resource::vhost { 'jenkins':
    ensure            => present,
    proxy             => "http://localhost:8080",
    listen_ip         => '217.66.55.72',
  }

  include ::git
#  erstmal auskommentiert, bis ein besseres Module gefunden wurde
#  include ::composer

  class { '::jenkins':
    version => latest,
    configure_firewall => false,
  }

  class { '::jenkins::cli_helper':
    ssh_keyfile => '/home/jenkins/.ssh/id_rsa',
  }

  class { '::jenkins::security':
    security_model => 'full_control',
  }

  user { "jenkins":
    ensure     => "present",
    managehome => true,
  }

  include ::site::profile::infrastructure::jenkins::plugins

  create_resources("::site::profile::infrastructure::jenkins::job", $jobs)
  create_resources("::jenkins::user", $users)
}