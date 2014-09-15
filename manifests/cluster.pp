class mysql::cluster {
	include mysql::cluster::packages
	include mysql::cluster::config

	class {
                'mysql::cluster::service':
                     bootstrap   => $mysql::bootstrap,
                     ensure      => $mysql::ensure,
    }

    Class['mysql::cluster::packages'] -> Class['mysql::cluster::config'] ->  Class['mysql::cluster::service'] -> Class['mysql::config']
	
}
