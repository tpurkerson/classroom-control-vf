class testuser {
  notify{"In testuser":}

  user { ['user1', 'user2']: 
    ensure => present 
  }

#  resources { 'user': 
#   purge => true 
#   }
}
