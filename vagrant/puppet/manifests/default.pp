node default {
  #
  # Define defaults for packages and services.
  #
  Package {
    ensure => 'installed',
    allow_virtual => false
  }

  Service {
    enable => true
  }

  #
  # Define paths
  #
  Exec { path => ["/bin", "/sbin", "/usr/bin", "/usr/sbin"] }

  #
  # Ensure epel-release installed
  #
  package { 'epel-release': }

  #
  # Include other modules
  #
  include 'composer'
  include 'extras'
  include 'nginx'
  include 'php'
  include 'nodejs'
  include 'mariadb'
  include 'sshkeys'
  include 'services'
}
