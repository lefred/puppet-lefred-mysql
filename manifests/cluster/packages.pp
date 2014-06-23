class mysql::cluster::packages {

  if  $mysql::mysql_distro == "mariadb" {
        $packs = [ "MariaDB-Galera-server", rsync ]
        $mysql_bin = "mysql"
  } elsif  $mysql::mysql_distro == "percona" {
        $packs = [ "Percona-XtraDB-Cluster-server-${mysql::mysql_ver}", "Percona-XtraDB-Cluster-client-${mysql::mysql_ver}", "Percona-Server-shared-compat", "Percona-XtraDB-Cluster-galera-${mysql::galera_version}", rsync ]
        $mysql_bin = "mysql"
  }
  
  info("Distro is $mysql::mysql_distro")

  package {
        $packs:
                    require => Yumrepo['mysql-repo'],
                    ensure => "installed";
  }

}
