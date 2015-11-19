class wrappers::sysctl {

  sysctl { 'net.core.somaxconn':
    value => '65536',
  }

  sysctl { 'vm.swappiness': 
    ensure => absent,
  }
}
