class mysql::utilities {

    yumrepo {
        "mysql-tools-community":
            descr   => "MySQL Tools Community",
            enabled     => 1,
            baseurl     => "http://repo.mysql.com/yum/mysql-tools-community/el/$mysql::repository::releasever/$mysql::repository::basearch/",
            gpgcheck    => 0;
        "mysql-connectors-community":
            descr   => "MySQL Connectors Community",
            enabled     => 1,
            baseurl     => "http://repo.mysql.com/yum/mysql-connectors-community/el/$mysql::repository::releasever/$mysql::repository::basearch/",
            gpgcheck    => 0;

    }   

	package {
        "mysql-utilities":
    	    ensure   => installed,
			    require  => [ YumRepo['mysql-tools-community'], YumRepo['mysql-connectors-community'] ];
        #"mysql-utilities-extra":
    	  #    ensure   => installed,
		    #	   require  => Package['mysql-utilities'];
		}
}
