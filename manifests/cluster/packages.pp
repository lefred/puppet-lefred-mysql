class mysql::cluster::packages {

  if  $mysql::mysql_distro == "mariadb" {
        $packs = [ "MariaDB-Galera-server", rsync ]
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
        $packs = [ "Percona-XtraDB-Cluster-server-${mysql::mysql_ver}", "Percona-XtraDB-Cluster-client-${mysql::mysql_ver}", "rsync", "qpress" ]
        $mysql_bin = "mysql"
        case $::osfamily {
    	  'RedHat': {
                $packs_galera = [ "Percona-XtraDB-Cluster-galera-${mysql::galera_version}", "Percona-Server-shared-compat" ]
                $require = [ Package[$packs_galera], Yumrepo['epel'] ]
               	$require_loc = Yumrepo['mysql-repo'] 
          }
          'Debian': {
                $packs_galera = "Percona-XtraDB-Cluster-galera-${mysql::galera_version}.x"
		$require = Package[$packs_galera]
		$require_loc = Apt::Source['mysql-repo']
          }
        }
        package {
            $packs_galera:
                    require => $require_loc,
                    ensure  => "installed";
        }
  }
  
  info("Distro is $mysql::mysql_distro")

  package {
        $packs:
                    require => $require,
                    ensure  => "installed";
  }

}
