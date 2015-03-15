node default {
  include samba
}

node 'pf-together-program.local' {
  class {'samba::server':
    workgroup => 'PIXELPARK',
    server_string => 'VM pfizer together',
  }

  samba::server::share {'vm-pfizer-together':
    browsable => true,
    comment => 'VM pfizer together',
    create_mask => 0777,
    directory_mask => 0777,
    force_user => 'vagrant',
    force_group => 'vagrant',
    guest_ok => true,
    read_only => false,
    path => '/var/www/',
  }
}
