class site::profile::ansible {
  package {'ansible':
    ensure => latest,
  }

  include ::python
}
