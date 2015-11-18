class nginx { 
  $wwwdir = '/var/www'
  
  File {
  group=> 'root',
  }
  
  package { 'nginx':
    ensure => present,
  }

  file { "${wwwdir}":
    ensure => directory, 
    owner => 'root', 
#    group => 'root', 
    mode => '0755',
    }

  file { "${wwwdir}/index.html": 
    ensure => file,
    owner => 'root',
#    group => 'root',
    mode   => '0644',
    source => 'puppet:///modules/nginx/index.html',
    }

  file { '/etc/nginx/nginx.conf':
    ensure => file,
    source => 'puppet:///modules/nginx/nginx.conf',
    require => Package['nginx'],
    notify => Service['nginx'],
    }

  file { '/etc/nginx/conf.d': 
    ensure => directory, 
    owner => 'root',
#    group => 'root',
    mode   => '0755',
    }
         
  file { '/etc/nginx/conf.d/default.conf':
    ensure => file,
    source => 'puppet:///modules/nginx/default.conf',
    require => Package['nginx'],
    notify => Service['nginx'],
    }

  service { 'nginx': 
    ensure => running, 
    enable => true,
    }
}
