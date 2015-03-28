class site::role::typo3_server (
  $typo3_sites = {}
) {
  validate_hash($typo3_sites)
  info("It's a single Typo3 Server!")

  include ::site::profile::base
  include ::site::profile::typo3_web_server
  include ::site::profile::mysql_server

  create_resources("::site::profile::typo3_web_server::site", $typo3_sites)
}
