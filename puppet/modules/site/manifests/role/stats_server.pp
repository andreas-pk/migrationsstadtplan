class site::role::stats_server {
  info("Here goes the data.")

  include site::profile::base
  include site::profile::graphite_server
  include site::profile::elasticsearch_server
  include site::profile::dashboard_server
}