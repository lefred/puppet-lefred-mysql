class mysql ($mysql_distro="community", $mysql_version="5.5", $mysql_serverid=undef, $ensure="running", $bootstrap=undef, $galera_version=2,  $mysql_bind_interface="eth0") {
        
        if $mysql::mysql_version == "5.7" {
            info("Your are brave ! Using 5.7 !!")
            $mysql_ver="57"
        } elsif $mysql::mysql_version == "5.6" {
            info("Congrats ! Using 5.6 !!")
            $mysql_ver="56"
        } elsif $mysql::mysql_version == "5.5" {
            info("You are conservative ! Using 5.5 !!")
            $mysql_ver="55"
        } elsif $mysql::mysql_version == "10" {
            info("You go to something new...  ! Using 10 !!")
            $mysql_ver="10.0"
        }


        $mysql_ip = inline_template("<% scope.lookupvar('::ipaddress_${mysql_bind_interface}') -%>")
        info("Interface to use = $mysql_bind_interface")
        info("Its IP is $mysql_ip")



        include mysql::repository

}
