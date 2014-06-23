class mysql::cluster::service ($ensure="running", $bootstrap=False) {
        
   	if ($bootstrap == True)   {
            if ($mysql::distro == "percona") {
        	    $service_start = "service mysql bootstrap-pxc"
            } else {
        	    $service_start = "service mysql bootstrap"
            }
    }

	service {
		"mysql":
			enable  => true,
            ensure  => $ensure,
			subscribe => File['/etc/my.cnf'],
            require => Package[$mysql::cluster::packages::packs],
            start => $service_start,
	}
}
