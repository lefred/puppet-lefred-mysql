class mysql::percona_xtrabackup {
    
    include mysql::percona_common

	package {
		"percona-xtrabackup":
            require  => [ Yumrepo[$mysql::percona_common::repo_req], Package[$mysql::percona_common::packs] ],
			ensure  => installed;
	}
}
