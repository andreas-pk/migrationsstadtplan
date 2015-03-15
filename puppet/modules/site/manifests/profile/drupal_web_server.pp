class site::profile::drupal_web_server {
  package {'php-drush-drush':
    ensure => latest,
  }

  include ::site::profile::php_server
}
