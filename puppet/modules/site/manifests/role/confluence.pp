class site::role::confluence {
  include ::site::profile::tomcat
  include ::site::profile::apache
  include ::site::profile::postgresql
}
