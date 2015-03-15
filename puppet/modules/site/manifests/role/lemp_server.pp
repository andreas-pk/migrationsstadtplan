class site::role::lemp_server (
  $sites = {}
) {
  info("It's a monolithic lemp server!")

  create_resources("site::profile::lemp_web_server::site", $sites)

  include site::profile::base
  include site::profile::lemp_web_server
  include site::profile::mysql_server
}
