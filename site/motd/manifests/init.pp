class motd {
  exec {"cowsay 'Weclome to ${::fqdn}!' > /etc/motd":
  path => '/usr/bin:/usr/local/bin',
  creates => '/etc/motd',
  }
  }
