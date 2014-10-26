class mysql::server::packages {

  if $mysql::mysql_distro == "community" {
        $packs = [ "mysql-community-server", "mysql-community-client", "mysql-community-libs-compat" ]
        $mysql::packdevel = "mysql-devel"
        $mysql_bin = "mysqld"
        $require =  Yumrepo['mysql-repo']
  } elsif  $mysql::mysql_distro == "mariadb" {
        $packs = [ "MariaDB-server", "MariaDB-client", "MariaDB-compat" ]
        $mysql::packdevel = "MariaDB-devel"
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
            $mysql::packdevel = "Percona-Server-devel-${mysql::mysql_ver}"
            $require = [ Yumrepo['mysql-repo'], Package["Percona-Server-shared-compat"] ]
            package {
              "Percona-Server-shared-compat":
                    require =>  Yumrepo['mysql-repo'], 
                    ensure  => "installed";
            }
           }
           'Debian': {
             $packs = [ "Percona-Server-server-${mysql::mysql_version}", "Percona-Server-client-${mysql::mysql_version}" ]
            $mysql::packdevel = "Percona-Server-server-devel-${mysql::mysql_ver}"
             $require = Apt::Source['mysql-repo']
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
