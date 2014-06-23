class mysql::percona_common {

    if $mysql::mysql_distro != "percona" {

        yumrepo {
            "percona":
                descr       => "Percona",
                enabled     => 1,
                baseurl     => "http://repo.percona.com/centos/$mysql::repository::releasever/os/$mysql::repository::basearch/",
                gpgcheck    => 0;
        }

        $repo_req = "percona"
    } else {
        $repo_req = "mysql-repo"
    }

    if defined(Class["mysql::server"]) {
            $packs = $mysql::server::packages::packs
    } else {
            $packs = $mysql::cluster::packages::packs
    } 

}
