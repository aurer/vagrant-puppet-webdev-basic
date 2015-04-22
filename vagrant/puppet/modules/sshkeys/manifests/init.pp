class sshkeys {
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
}