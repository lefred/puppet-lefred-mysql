class mysql::server  {
        include mysql::server::packages
	    include mysql::server::config
	    include mysql::server::service
        
        Class['mysql::server::packages'] -> Class['mysql::server::config'] ->  Class['mysql::server::service'] -> Class['mysql::config']
}
