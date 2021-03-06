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
 	package {
        	   $packs:
                      require => $require,
                      ensure  => "installed";
  	}
  } elsif  $mysql::mysql_distro == "percona" {
        $mysql_bin = "mysql"
        case $::osfamily {
    	  'RedHat': {
                $packs = [ "Percona-XtraDB-Cluster-server-${mysql::mysql_ver}", "Percona-XtraDB-Cluster-client-${mysql::mysql_ver}", "rsync", "qpress" ]
                $packs_galera = [ "Percona-XtraDB-Cluster-galera-${mysql::galera_version}", "Percona-Server-shared-compat" ]
                $require = [ Package[$packs_galera], Yumrepo['epel'] ]
  		package {
            	   $packs_galera:
                      require => $require_loc,
                      ensure  => "installed";
        	   $packs:
                      require => $require,
                      ensure  => "installed";
  	 	}
               	$require_loc = Yumrepo['mysql-repo'] 
          }
          'Debian': {
                $packs = [ "Percona-XtraDB-Cluster-server-${mysql::mysql_version}", "Percona-XtraDB-Cluster-client-${mysql::mysql_version}", "rsync", "qpress" ]
                $packs_galera = "Percona-XtraDB-Cluster-galera-${mysql::galera_version}.x"
		$require = Package[$packs_galera]
		$require_loc = Apt::Source['mysql-repo']


		file { 
			"/usr/sbin/policy-rc.d":
				source => "puppet:///modules/mysql/policy-rc.d",
				mode => "a+x",
				ensure => present,
		}
  		package {
            	   $packs_galera:
                      require => $require_loc,
                      ensure  => "installed";
        	   $packs:
                      require => $require,
                      ensure  => "installed";
  		} -> exec {
			"delete policy-rc.d":
				command => "rm /usr/sbin/policy-rc.d",
				path => ["/usr/bin", "/bin" ],
				provider => shell,
				onlyif => ["test -f /usr/sbin/policy-rc.d" ]
		}
          }
     }
  }
  
  info("Distro is $mysql::mysql_distro")


}
