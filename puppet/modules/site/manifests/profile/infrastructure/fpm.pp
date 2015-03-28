class site::profile::infrastructure::fpm {
  package {'ruby-devel':
    ensure => latest,
  }

  package {'rpm-build':
    ensure => latest,
  }

  package {'gcc':
    ensure => latest,
  }

  package {'fpm':
    ensure => latest,
    provider => gem,
    require => Package[ 'gcc', 'ruby-devel', 'rpm-build'],
  }
}
