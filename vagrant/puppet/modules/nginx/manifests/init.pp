class nginx {

  # Install Nginx package
  package { 'nginx':
    require => Yumrepo['epel']
  }

  # Use a custom php-fpm configuration file
  file { '/etc/nginx/nginx.conf':
    source  => 'puppet:///modules/nginx/nginx.conf',
    owner => 'root',
    group => 'root',
    mode => 0644,
    require => Package['nginx'],
    notify  => Service['nginx'],
  }
}