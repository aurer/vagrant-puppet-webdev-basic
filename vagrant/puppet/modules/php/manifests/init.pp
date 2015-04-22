class php {
  # Add IUS repository and install common PHP 5.5 packages.
  yumrepo { 'ius':
    baseurl => 'http://dl.iuscommunity.org/pub/ius/stable/CentOS/6/x86_64',
    descr => 'IUS Community',
    enabled => 1,
    gpgcheck => 0
  }

  # Install php packages
  $php_packages = [
    'php54-fpm',
    'php54-gd',
    'php54-mcrypt',
    'php54-mbstring',
    'php54-mysql',
    'php54-pdo',
    'php54-pear',
    'php54-xml'
  ]

  package { $php_packages: 
    require => Yumrepo['ius']
  }

  # Use a custom php-fpm configuration file
  file { '/etc/php-fpm.d/www.conf':
    source  => 'puppet:///modules/php/www.conf',
    owner => 'root',
    group => 'root',
    mode => 0644,
    require => Package['php54-fpm'],
    notify  => Service['php-fpm'],
  }

  # Start php
  service { 'php-fpm':
    require => Package['php54-fpm']
  }
}