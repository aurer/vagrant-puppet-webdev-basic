class nodejs {
  $packages = [
    'nodejs',
    'npm',
  ]
  package { $packages: }

  # Install grunt-cli
  exec { 'Install grunt':
    command => 'npm install -g grunt-cli',
    path    => '/usr/bin:/usr/sbin',
    require => Package['npm'],
    unless => 'which grunt &> /dev/null'
  }

  # Install gulp-cli
  exec { 'Install gulp':
    command => 'npm install -g gulp',
    path    => '/usr/bin:/usr/sbin',
    require => Package['npm'],
    unless => 'which gulp &> /dev/null'
  }
}
