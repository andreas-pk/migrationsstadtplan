class site::profile::jenkins_server (
  $jobs = {},
  $users = {}
) {
  include ::nginx

  nginx::resource::vhost { 'jenkins':
    ensure            => present,
    proxy             => "http://localhost:8080",
    listen_ip         => '217.66.55.72',
  }

  include git
  include composer

  class { 'jenkins':
    version => latest,
  }

  class { 'jenkins::cli_helper':
    ssh_keyfile => '/home/jenkins/.ssh/id_rsa',
  }

  class { 'jenkins::security':
    security_model => 'full_control',
  }

  user { "jenkins":
    ensure     => "present",
    managehome => true,
  }

  include site::profile::jenkins_server::plugins

  create_resources("site::profile::jenkins_server::job", $jobs)
  create_resources("jenkins::user", $users)
}
