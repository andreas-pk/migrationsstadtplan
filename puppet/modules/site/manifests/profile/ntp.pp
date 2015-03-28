class site::profile::ntp ($disable_ntp = false){
  # Begründung für $disable_ntp:
  # Eigentlich wollen wir allen physichen Maschinen den ntp Dienst mittels Puppet aufdrücken,
  # leider ist dies bei tim01-03 nicht möglich, weil der Konfigurationsparameter peer nicht unterstützt wird.
  # Solange folgendes Feature nicht fertig programmiert wurde, lassen wir die automatische ntp-Konfiguration auf diesen drei Rechner sein
  # Feature: https://tickets.puppetlabs.com/browse/MODULES-1836
  # Grüße Philipp D.


  # NTP wird nicht in Container Umgebungen betrieben
  if $::virtual == "" or $::virtual == 'zone' or $::virtual == 'openvz' or $::virtual == 'lxc' or $disable_ntp == true {
    # Do nothing
  } else {
    include ::ntp
  }
}