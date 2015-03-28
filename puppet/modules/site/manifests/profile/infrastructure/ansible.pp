class site::profile::infrastructure::ansible {
  package {'ansible':
    ensure => latest,
  }

  include ::python
}
