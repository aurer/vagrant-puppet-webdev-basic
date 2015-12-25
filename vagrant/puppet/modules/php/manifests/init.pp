class php {
  # Add Webtatic repository and install common PHP 7 packages.
  yumrepo { 'webtatic':
    baseurl => 'https://mirror.webtatic.com/yum/el7/',
    descr => 'Webtatic',
    enabled => 1,
    gpgcheck => 0
  }

  # PHP 7 packages
  $php_7_packages = [
    'php70w-fpm',
    'php70w-gd',
    'php70w-mcrypt',
    'php70w-mbstring',
    'php70w-mysqlnd',
    'php70w-pdo',
    'php70w-pear',
    'php70w-xml',
    'php70w-cli'
  ]

  # Install PHP 7 packages
  package { $php_7_packages:
    require => Yumrepo['webtatic']
  }

  # Ensure PHP run dir is present
  # file { '/var/run/php-fpm':
  #   ensure  => 'directory'
  # }

  # Ensure PHP Session dir is present
  # file { '/var/lib/php/session':
  #   ensure => 'directory',
  #   owner => 'nginx',
  #   group => 'nginx',
  #   mode => 755
  # }

  # Use a custom php-fpm configuration file
  file { '/etc/php-fpm.d/www.conf':
    source  => 'puppet:///modules/php/www.conf',
    owner => 'root',
    group => 'root',
    mode => 0644,
    require => Package['php70w-fpm'],
    notify  => Service['php-fpm'],
  }
}
