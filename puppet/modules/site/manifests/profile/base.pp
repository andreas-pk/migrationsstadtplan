class site::profile::base (
) {
  include ::site::profile::ntp
  include ::epel
  include ::repoforge

  exec {'yum_clean':
    command => '/usr/bin/yum clean all -y',
  }
  exec {'yum_makecache_fast':
    command => '/usr/bin/yum makecache fast'
  }

  # Make gem install a lot faster.
  # https://buddingrubyist.wordpress.com/2009/02/14/how-to-speed-up-gem-installs-10x/
  class { '::ruby::gemrc':
    gem_command => {
      'gem'  => [ 'no-ri', 'no-rdoc' ],
    }
  }

  # This apply all yum repository resources before applying any package resources,
  # which protects any packages that rely on custom repos.
  Yumrepo <| |> -> Exec[ 'yum_clean' ] -> Exec[ 'yum_makecache_fast' ] -> Package <| |>
}
