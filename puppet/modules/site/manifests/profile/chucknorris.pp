class site::profile::chucknorris {
  info('Chuck Norris at work!')

  file { '/etc/motd':
    content => "\nChuck Norris knows the last digit of pi.\n"
  }
}
