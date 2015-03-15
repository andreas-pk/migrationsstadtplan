class site::profile::mysql_server:slave (
) inherits site::profile::mysql_server {

  class { '::mysql::server':
    override_options => { 
      'mysqld' => {
        'server-id' => '2'
      }
    }
  }
}
