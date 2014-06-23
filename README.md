Puppet MySQL Module
============

This module is made for CentOS/RHEL (Yum based system) and allows to install different MySQL as a server
or as part of a Galera Cluster.

These are the supported distributions:

- Oracle MySQL Community (5.5, 5.6 and 5.7)
- MariaDB (5.5 and 10.0)
- Percona Server (5.5 and 5.6)
- MariaDB Galera Cluster (5.5 and 10.0 both with Galera 3)
- Percona XtraDB Cluster (5.5 and 5.6 with Galera 2 or 3)


MySQL-Utilities, Percona-Toolkit and Percona XtraBackup are also part of this module.


This is how to use it in the puppet manifest::

    node node1 {

        class {
            'mysql':
                            mysql_distro    => "percona",
                            mysql_version   => "5.6",
                            mysql_serverid  => "1",
                            galera_version  => "3",
                            bootstrap       => True,
                            ensure          => "running";
        }

        include mysql::cluster
        include mysql::utilities
        include mysql::percona_toolkit
        include mysql::percona_xtrabackup

    }


List of supported parameters
-----------------------------

+----------------+-----------------------------+
| mysql_distro   | community, mariadb, percona |
+----------------+-----------------------------+
| mysql_version  | 5.5, 5.6, 5.7, 10           |
+----------------+-----------------------------+
| galera_version | 2, 3                        |
+----------------+-----------------------------+
| bootstrap      | To bootstrap the cluster    |
+----------------+-----------------------------+
