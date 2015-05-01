class node {
  # Install node and npm
  $packages = [
    'nodejs',
    'npm'
  ]
  
  package { $packages: 
    require => Package['epel-release']
  }
}