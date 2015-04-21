node default {
  #
  # Define defaults for packages and services.
  #
  Package {
    ensure => 'installed',
    allow_virtual => false
  }

  Service {
    ensure => 'running',
    enable => true
  }

  #
  # Define paths
  #
  Exec { path => ["/bin", "/sbin", "/usr/bin", "/usr/sbin"] }

   #
  # Add EPEL repository and install Nginx package.
  #
  yumrepo { 'epel':
    baseurl => 'http://dl.fedoraproject.org/pub/epel/6/x86_64',
    descr => 'Extra Packages for Enterprise Linux',
    enabled => 1,
    gpgcheck => 0
  }

  package { 'nginx':
    require => Yumrepo['epel']
  }

  service { 'nginx':
    require => Package['nginx']
  }

  #
  # Add IUS repository and install common PHP 5.5 packages.
  #
  yumrepo { 'ius':
    baseurl => 'http://dl.iuscommunity.org/pub/ius/stable/CentOS/6/x86_64',
    descr => 'IUS Community',
    enabled => 1,
    gpgcheck => 0
  }

  $php_packages = [
    'php54-fpm',
    'php54-gd',
    'php54-mcrypt',
    'php54-mysql',
    'php54-pdo',
    'php54-pear',
    'php54-xml'
  ]

  package { $php_packages: 
    require => Yumrepo['ius']
  }

  service { 'php-fpm':
    require => Package['php54-fpm']
  }

  #
  # Install other important/useful packages.
  #
  $packages = [
    'git',
    'mysql-server',
    'nodejs',
    'npm'
  ]
  package { $packages: }

  #
  # Copy SSH keys into root user home directory (if source files exist).
  #
  file { '/root/.ssh': ensure => 'directory' }

  $id_rsa = file('/vagrant/puppet/files/root/.ssh/id_rsa', '/dev/null')
  $id_rsa_pub = file('/vagrant/puppet/files/root/.ssh/id_rsa.pub', '/dev/null')

  if ($id_rsa != '') {
    file { '/root/.ssh/id_rsa':
      content => $id_rsa,
      mode => '0600',
      require => File['/root/.ssh']
    }
  }

  if ($id_rsa_pub != '') {
    file { '/root/.ssh/id_rsa.pub':
      content => $id_rsa_pub,
      mode => '0600',
      require => File['/root/.ssh']
    }
  }

  #
  # Install dotfiles
  #
  exec { "create_dotfiles":
    command => "git clone https://github.com/aurer/dotfiles.git /root/dotfiles && source /root/dotfiles/bootstrap.sh -f",
    require => Package['git'],
    creates => "/root/dotfiles"
  }

  #
  # Install nginx includes
  #
  exec { "create_nginx_includes":
    command => "git clone https://github.com/aurer/nginx-conf.git /etc/nginx/includes",
    require => [
      Package['git'],
      Package['nginx']
    ],
    creates => "/etc/nginx/includes"
  }

  #
  # Put an example virtual host file in /etc/nginx.
  #
  file { '/etc/nginx/vhost-example.conf':
    source => '/vagrant/puppet/files/nginx/vhost-example.conf',
    owner => 'root',
    group => 'root',
    mode => '0644',
    require => Package['nginx']
  }

  #
  # Start services.
  #
  # service { 'mysqld': require => Package['mysql-server'] }

  # Turn the firewall off so that we don't have to punch a hole in it just to
  # get a local development environment working.
  service { 'iptables': ensure => 'stopped' }
}
