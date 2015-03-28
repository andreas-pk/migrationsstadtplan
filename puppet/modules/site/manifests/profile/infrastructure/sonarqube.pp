class site::profile::infrastructure::sonarqube {
  include ::nginx

  nginx::resource::vhost { 'sonar':
    ensure            => present,
    proxy             => "http://localhost:9000",
    listen_ip         => '217.66.55.71',
  }

  include ::java
  include ::maven

  $jdbc = {
    url        => 'jdbc:mysql://localhost:3306/sonar?useUnicode=true&amp;characterEncoding=utf8&amp;rewriteBatchedStatements=true',
    username   => 'sonar',
    password   => 'sonar',
  }
  $ldap = {
    url          => 'ldap://ldap.pixelpark.com',
    user_base_dn => 'ou=People,o=Pixelpark,o=isp',
  }

  class { '::sonarqube' :
    version     => '4.5.2',
    jdbc        => $jdbc,
    installroot => '/var/lib',
    ldap        => $ldap,
    log_folder  => '/var/logs/sonar',
  }

  sonarqube::plugin { 'sonar-php-plugin' :
    version => '2.4',
    groupid => 'org.codehaus.sonar-plugins.php',
    notify => Service['sonar'],
    require => Class[ '::maven::maven' ],
  }
  sonarqube::plugin { 'sonar-css-plugin' :
    version => '1.1',
    groupid => 'org.codehaus.sonar-plugins.css',
    notify => Service['sonar'],
    require => Class[ '::maven::maven' ],
  }
  sonarqube::plugin { 'sonar-web-plugin' :
    version => '2.3',
    groupid => 'org.codehaus.sonar-plugins',
    notify => Service['sonar'],
    require => Class[ '::maven::maven' ],
  }
  sonarqube::plugin { 'sonar-javascript-plugin' :
    version => '2.2',
    groupid => 'org.codehaus.sonar-plugins.javascript',
    notify => Service['sonar'],
    require => Class[ '::maven::maven' ],
  }

  class {'::sonarqube::runner':
    jdbc        => $jdbc,
    installroot => '/var/lib',
    sonarqube_server => 'http://localhost:9000/',
  }
}