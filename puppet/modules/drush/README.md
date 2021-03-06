Drush Puppet
===============

Manages the installation and configuration of Drush using Composer.

Features
--------

- Drush cli installation
- Execute core drush commands from puppet
    - site-install
    - pm-enable
    - pm-download
    - etc...
- Enables auto-complete configuration (see [drush.complete.sh](https://github.com/drush-ops/drush/blob/master/drush.complete.sh))
- Configure /etc/drush/drush.ini file through Hiera

Roadmap Features
----------------

- Site aliases configuration via Hiera
- Policy files via Hiera
- drushrc.php configuration

Dependencies
------------

Since Drush requires composer to be installed, this module depends on our fork of [tPl0ch/composer](https://forge.puppetlabs.com/tPl0ch/composer) to install drush. Once v2 is released with "global" and "require" support our fork of this puppet module will be deprecated.

- [Composer Puppet Module](https://github.com/coldfrontlabs/puppet-composer)

Testing
-------

This module is primarily tested on CentOS. If someone wants to test and commit patches for other Linux distros please do so.

Sample Configuration
--------------------

#### Include drush
````puppet
include drush
````

or

````puppet
class {'drush':
  version => '6.*',  # Version options include specific values like '6.2.0', latest stable as '6.*' or dev with 'dev-master'
  drush_cmd => '/usr/bin/drush', # Directory to place the drush executable
  composer_home => '/usr/local/share/composer', # Directory where composer will install drush
}
````

#### Running commands
````puppet
drush::si {"drush-si-${name}":
    profile => $profile,
    db_url => $db_url,
    site_root => $site_root,
    account_name => $account_name,
    account_pass => $account_pass,
    account_mail => $account_mail,
    clean_url => $clean_url,
    db_prefix => $db_prefix,
    db_su => $db_su,
    db_su_pw => $db_su_pw,
    locale => $locale,
    site_mail => $site_mail,
    site_name => $site_name,
    sites_subdir => $sitessubdir,
    settings => $keyvalue,
    onlyif => "test ! -f ${site_root}/sites/${sitessubdir}/settings.php -a -f ${site_root}/index.php",
    require => [
      Drupalsi::Distro[$distro],
    ]
  }
````

#### Hiera Configuration

Some configuration options can be passed in through Hiera

##### /etc/drush/drush.ini

````yaml
drush::ini:
    memory_limit: 128M
    max_execution_time: 300
    error_reporting: E_ALL | E_NOTICE | E_STRICT
    display_errors: stderr
````

For more examples, see the [Drupal Site Install puppet module](https://github.com/coldfrontlabs/coldfrontlabs-drupalsi).