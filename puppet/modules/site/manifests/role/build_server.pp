class site::role::build_server {
  info("It's a monolithic build server!")

  include ::site::profile::infrastructure::jenkins
  include ::site::profile::infrastructure::nexus
  include ::site::profile::infrastructure::ansible
  include ::site::profile::infrastructure::sonarqube
  include site::profile::mysql_server
  include site::profile::web_server
}
