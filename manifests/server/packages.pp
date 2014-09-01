class mysql::server::packages {

  if $mysql::mysql_distro == "community" {
        $packs = [ "mysql-community-server", "mysql-community-client", "mysql-community-libs-compat" ]
        $mysql_bin = "mysqld"
        $require =  Yumrepo['mysql-repo']
  } elsif  $mysql::mysql_distro == "mariadb" {
        $packs = [ "MariaDB-server", "MariaDB-client", "MariaDB-compat" ]
        $mysql_bin = "mysql"
        case $::osfamily {
          'RedHat': {
                $require = Yumrepo['mysql-repo']
          }
          'Debian': {
                $require = Apt::Source['mysql-repo']
          }
        }
  } elsif  $mysql::mysql_distro == "percona" {
        $mysql_bin = "mysql"
        case $::osfamily {
          'RedHat': {
            $packs = [ "Percona-Server-server-${mysql::mysql_ver}", "Percona-Server-client-${mysql::mysql_ver}" ]
            $require = Package["Percona-Server-shared-compat"]
            package {
              "Percona-Server-shared-compat":
                    require =>  Yumrepo['mysql-repo'], 
                    ensure  => "installed";
           }
           'Debian': {
             $packs = [ "Percona-Server-server-${mysql::mysql_version}", "Percona-Server-client-${mysql::mysql_version}" ]
             $require_loc = Apt::Source['mysql-repo']
             package {
                $packs:
                      require => $require,
                      ensure  => "installed";
             }
           }
        }
  }
  
  info("Distro is $mysql::mysql_distro")

  package {
        $packs:
         	require => $require,
	        ensure => "installed";
  }
}
