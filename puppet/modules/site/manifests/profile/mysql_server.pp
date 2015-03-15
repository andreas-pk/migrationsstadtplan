class site::profile::mysql_server (
  $databases = {}
) {

  class { '::mysql::server':
    restart => true,
    service_manage => true,
    override_options => {
      'mysqld' => {
        'bind-address' => ['0.0.0.0']
      }
    }
  }

  create_resources("mysql::db", $databases)
}
