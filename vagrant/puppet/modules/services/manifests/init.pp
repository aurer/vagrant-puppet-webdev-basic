class services {
	Service {
    ensure => 'running',
    enable => true
  }

  # Nginx
	service { 'nginx':
    require => Package['nginx'],
  }

  # PHP
  service { 'php-fpm':
    require => [Package['php55u-fpm'], Package['nginx']],
  }

  # Mariadb
  service { 'mariadb':
  	require => Package['mariadb-server'],
  }

  # Firewall
  service { 'firewalld': 
    ensure => 'stopped' 
  }
}
