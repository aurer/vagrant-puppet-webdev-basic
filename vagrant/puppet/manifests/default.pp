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

  # Add EPEL repository.
  yumrepo { 'epel':
    baseurl => 'http://dl.fedoraproject.org/pub/epel/6/x86_64',
    descr => 'Extra Packages for Enterprise Linux',
    enabled => 1,
    gpgcheck => 0
  }
  
  #
  # Include other modules
  #
  include 'composer'
  include 'extras'
  include 'nginx'
  include 'php'
  include 'sshkeys'
}
