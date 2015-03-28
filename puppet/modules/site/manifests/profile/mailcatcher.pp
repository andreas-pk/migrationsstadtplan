class site::profile::mailcatcher (
){
  # http://berk.es/2011/05/29/mailcatcher-for-drupal-and-other-php-applications-the-simple-version/
  Service['postfix'] ->
  class {'::mailcatcher':
    smtp_port => '25',
    http_port => '1000',
  }

  service { "postfix":
    ensure => "stopped",
  }

  #sendmail_path = /usr/bin/env /usr/local/share/gems/gems/mailcatcher-0.6.1/bin/catchmail --smtp-port 25
}
