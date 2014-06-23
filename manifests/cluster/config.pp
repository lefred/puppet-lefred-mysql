class mysql::cluster::config  {

        $mysql_version          = $mysql::mysql_version
        $mysqlserverid          = $mysql::mysql_serverid

        file {
                "/etc/my.cnf":
                        ensure  => present,
                        content => template("mysql/cluster/my.cnf.erb"),
        }

        exec {
                "disable-selinux":
                        path    => ["/usr/bin","/bin"],
                        command => "echo 0 >/selinux/enforce",
                        unless => "grep 0 /selinux/enforce",
        }

}
