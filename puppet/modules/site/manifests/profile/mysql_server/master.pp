class site::profile::mysql_server:master (
) inherits site::profile::mysql_server {
  #http://nerdier.co.uk/2013/12/07/mysql-replication-with-puppet/


  class { '::mysql::server':
    override_options => { 
      'mysqld' => {
        'log-bin'         => 'mysql-bin',
        'server-id'       => '1',
        'bind_address'    => '192.168.30.100'
      }
    },
    users => {
      'repl@%' => {
         ensure           => 'present',
         password_hash    => mysql_password('repl')
      }
    },
    grants => {
      'repl@%/*.*' => {
          ensure      => 'present',
          options     => ['GRANT'],
          privileges  => ['REPLICATION SLAVE'],
          table       => '*.*',
          user        => 'repl@%'
      }
    }
  }
}
