class mysql::repository {

 case $::osfamily {
    'RedHat': {
 	$releasever = "6"
 	$basearch = $hardwaremodel


 	if $mysql::mysql_distro == "community" {
            $repo_descr = "MySQL $mysql::mysql_version Community Server"
            $repo_url   = "http://repo.mysql.com/yum/mysql-${mysql::mysql_version}-community/el/$releasever/$basearch/"
 	} elsif $mysql::mysql_distro == "mariadb" {
            $repo_descr = "MariaDB ${mysql_ver}"
            $repo_url   =  "http://yum.mariadb.org/${mysql::mysql_version}/centos6-amd64/"
 	} elsif  $mysql::mysql_distro == "percona" {
            $repo_descr = "Percona"
            $repo_url   = "http://repo.percona.com/centos/$releasever/os/$basearch/"
 	}

 	yumrepo {
     		"mysql-repo":
            		descr       => $repo_descr,
            		enabled     => 1,
            		baseurl     => $repo_url,
            		gpgcheck    => 0;
     		"epel":
            		descr       => "Extra Packages for Enterprise Linux $releasever - $basearch",
            		enabled     => 1,
            		baseurl     => "http://download.fedoraproject.org/pub/epel/$releasever/$basearch",
            		gpgcheck    => 0;
	}

    }
    'Debian': {
	include ::apt

 	if $mysql::mysql_distro == "community" {
            $repo_descr      = "MySQL $mysql::mysql_version Community Server"
            $repo_url        = "http://repo.mysql.com/apt/ubuntu/"
            $repo_repos      = "mysql-${mysql::mysql_version}"
            $repo_release    = $lsbdistcodename 
	    $repo_key	     = "5072E1F5"
	    $repo_key_source = false
 	} elsif $mysql::mysql_distro == "mariadb" {
            $repo_descr      = "MariaDB ${mysql_ver}"
            $repo_lsbdistid  = downcase($lsbdistid)
            $repo_url        =  "http://mariadb.cu.be//repo/${mysql::mysql_version}/${repo_lsbdistid}"
            $repo_repos      = "main"
            $repo_release    = $lsbdistcodename 
	    $repo_key	     = "0xcbcb082a1bb943db" 
	    $repo_key_source = false
 	} elsif  $mysql::mysql_distro == "percona" {
            $repo_descr      = "Percona"
            $repo_url        = "http://repo.percona.com/apt/"
            $repo_repos      = "experimental"
            $repo_release    = $lsbdistcodename 
	    $repo_key	     = "1C4CBDCDCD2EFD2A" 
	    $repo_key_source = "http://mirror.openminds.be/keys/1C4CBDCDCD2EFD2A.asc"
        }
 
        apt::source {
		"mysql-repo":
			location	=> $repo_url,
			release		=> $repo_release,
			repos		=> $repo_repos,
			key		=> $repo_key,
			key_source	=> $repo_key_source,
			include_src	=> false
        }

    }  
  }
}
