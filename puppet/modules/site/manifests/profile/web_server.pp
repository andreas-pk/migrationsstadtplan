class site::profile::web_server (
  $sites = {}
){
  include ::nginx

  create_resources("site::profile::web_server::site", $sites)
}
