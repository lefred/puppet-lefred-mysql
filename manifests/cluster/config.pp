class mysql::cluster::config  {

        $mysql_version          = $mysql::mysql_version
        $mysqlserverid          = $mysql::mysql_serverid

       
        case $::osfamily {
          'RedHat': {
        	exec {
                	"disable-selinux":
                        	path    => ["/usr/bin","/bin"],
                        	command => "echo 0 >/selinux/enforce",
                        	unless => "grep 0 /selinux/enforce",
        	}

	       $my_file="/etc/my.cnf"
	  }
          'Debian': {
	       $my_file="/etc/mysql/my.cnf"
          }
        }

        file {
                "my.cnf":
                	path    => $my_file,
                        ensure  => present,
                        content => template("mysql/cluster/my.cnf.erb"),
        }
}
