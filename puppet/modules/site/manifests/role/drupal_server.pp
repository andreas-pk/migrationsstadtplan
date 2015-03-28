class site::role::drupal_server (
  $drupal_sites = {}
) {
  validate_hash($drupal_sites)
  info("It's a single Drupal Server!")

  include ::site::profile::base
  include ::site::profile::drupal_web_server
  include ::site::profile::mysql_server
  include ::site::profile::mailcatcher

  create_resources("site::profile::drupal_web_server::site", $drupal_sites)
}
