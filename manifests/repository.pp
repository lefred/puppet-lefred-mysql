class mysql::repository {


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

