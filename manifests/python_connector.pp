class mysql::python_connector {
 
 
  case $::osfamily {
          'RedHat': {
                $pack = "MySQL-python"
          }
          'Debian': {
                $pack = "python-mysqldb"
          }
  } 
  
  package {
    $pack:
      ensure  => installed,
      require => Class['mysql']
  }
}
