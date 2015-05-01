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
    'php55u-fpm',
    'php55u-gd',
    'php55u-mcrypt',
    'php55u-mbstring',
    'php55u-mysqlnd',
    'php55u-pdo',
    'php55u-pear',
    'php55u-xml',
    'php55u-cli'
  ]

  file { '/var/run/php-fpm':
    ensure  => 'directory'
  }

  file { '/var/lib/php/session':
    ensure => 'directory',
    owner => 'nginx',
    group => 'nginx',
    mode => 755
  }

  package { $php_packages: 
    require => Yumrepo['ius']
  }

  # Use a custom php-fpm configuration file
  file { '/etc/php-fpm.d/www.conf':
    source  => 'puppet:///modules/php/www.conf',
    owner => 'root',
    group => 'root',
    mode => 0644,
    require => Package['php55u-fpm'],
    notify  => Service['php-fpm'],
  }
}