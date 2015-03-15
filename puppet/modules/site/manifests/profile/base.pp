class site::profile::base (
  $hosts = {}
) {
  create_resources("host", $hosts)
  include ntp
  include epel
  include repoforge
}
