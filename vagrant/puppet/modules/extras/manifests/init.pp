class extras {

  #
  # Install other important/useful packages.
  #
  $packages = [
    'vim-enhanced',
    'git',
    'wget',
		'telnet',
  ]

  package { $packages:
    require => Package['epel-release']
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
}
