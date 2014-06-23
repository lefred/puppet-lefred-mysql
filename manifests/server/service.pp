class mysql::server::service {

	service {
		"mysql":
			enable  => true,
            name    => $mysql::server::packages::mysql_bin,
            ensure  => $mysql::ensure,
			require => Package[$mysql::server::packages::packs],
	}

}
