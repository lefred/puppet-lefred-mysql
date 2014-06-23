class mysql::percona_toolkit {
    include mysql::percona_common
    
	package {
        	"percona-toolkit":
                	ensure   => installed,
                    require  => [ Yumrepo[$mysql::percona_common::repo_req], Package[$mysql::percona_common::packs] ]
                    
	}

}
