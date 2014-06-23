class mysql::server::packages {

  if $mysql::mysql_distro == "community" {
        $packs = [ "mysql-community-server", "mysql-community-client", "mysql-community-libs-compat" ]
        $mysql_bin = "mysqld"
  } elsif  $mysql::mysql_distro == "mariadb" {
        $packs = [ "MariaDB-server", "MariaDB-client", "MariaDB-compat" ]
        $mysql_bin = "mysql"
  } elsif  $mysql::mysql_distro == "percona" {
        $packs = [ "Percona-Server-server-${mysql::mysql_ver}", "Percona-Server-client-${mysql::mysql_ver}", "Percona-Server-shared-compat" ]
        $mysql_bin = "mysql"
  }
  
  info("Distro is $mysql::mysql_distro")

  package {
        $packs:
            		require => Yumrepo['mysql-repo'],
			        ensure => "installed";
  }
}
