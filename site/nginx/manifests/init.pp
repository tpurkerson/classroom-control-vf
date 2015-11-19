class nginx {
case $::osfamily {
           'redhat','debian' : { 
                      $package = 'nginx' $owner = 'root' $group = 'root' $docroot = '/var/www' $confdir = '/etc/nginx'
                      }
           'windows' : {
                      $package = 'nginx-service'
                      $owner = 'Administrator'
                      $group = 'Administrators'
                      $docroot = 'C:/ProgramData/nginx/html' $confdir = 'C:/ProgramData/nginx'
                      }
           default : {
                      fail("Module ${module_name} is not supported on ${::osfamily}")
                      }
           }
File {
           owner => $owner,
           group => $group,
           mode  => '0664',
}

package { $package:
           ensure => present, 
}

file { [ $docroot, "${confdir}/conf.d" ]: 
           ensure => directory,
}

file { "${docroot}/index.html":
           ensure => file,
#           source => 'puppet:///modules/nginx/index.html',
           source => template('nginx/index.html.erb'),
}

file { "${confdir}/nginx.conf":
           ensure => file,
           source => "puppet:///modules/nginx/${::osfamily}.conf", 
           notify => Service['nginx'],
}

file { "${confdir}/conf.d/default.conf":
           ensure => file,
           source => "puppet:///modules/nginx/default-${::kernel}.conf", 
           notify => Service['nginx'],
}

service { 'nginx':
           ensure => running,
           enable => true, 
}
}
