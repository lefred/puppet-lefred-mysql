class mysql::cluster::packages {

  if  $mysql::mysql_distro == "mariadb" {
        $packs = [ "MariaDB-Galera-server", rsync ]
        $mysql_bin = "mysql"
        $packs_galera = undef 
  } elsif  $mysql::mysql_distro == "percona" {
        $packs = [ "Percona-XtraDB-Cluster-server-${mysql::mysql_ver}", "Percona-XtraDB-Cluster-client-${mysql::mysql_ver}", "Percona-Server-shared-compat", "rsync" ]
        $packs_galera = [ "Percona-XtraDB-Cluster-galera-${mysql::galera_version}" ]
        $mysql_bin = "mysql"
        info("packs_galera: $packs_galera")
        info("packs: $packs")
        info("require_pack: $require_pack")
        package {
            $packs_galera:
                    require => Yumrepo['mysql-repo'],
                    ensure  => "installed";
        }
  }
  
  info("Distro is $mysql::mysql_distro")

  package {
        $packs:
                    require => [ Yumrepo['mysql-repo'], Package[$packs_galera] ],
                    ensure  => "installed";
  }

}
