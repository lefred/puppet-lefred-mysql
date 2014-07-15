class mysql::server::packages {

  if $mysql::mysql_distro == "community" {
        $packs = [ "mysql-community-server", "mysql-community-client", "mysql-community-libs-compat" ]
        $mysql_bin = "mysqld"
        $require =  Yumrepo['mysql-repo']
  } elsif  $mysql::mysql_distro == "mariadb" {
        $packs = [ "MariaDB-server", "MariaDB-client", "MariaDB-compat" ]
        $mysql_bin = "mysql"
        $require =  Yumrepo['mysql-repo']
  } elsif  $mysql::mysql_distro == "percona" {
        $packs = [ "Percona-Server-server-${mysql::mysql_ver}", "Percona-Server-client-${mysql::mysql_ver}" ]
        $mysql_bin = "mysql"
        $require = Package["Percona-Server-shared-compat"]
        package {
            "Percona-Server-shared-compat":
                    require =>  Yumrepo['mysql-repo'], 
                    ensure  => "installed";
        }
  }
  
  info("Distro is $mysql::mysql_distro")

  package {
        $packs:
         	require => $require,
	        ensure => "installed";
  }
}
