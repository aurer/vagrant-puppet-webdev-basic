class mariadb {
  # Install mariadb packages
  $mariadb_packages = [
    'mariadb',
    'mariadb-server',
  ]

  package { $mariadb_packages: }
}
