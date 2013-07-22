class observatory::ps {

    require "apt";

    package {
        "postgresql-9.1":
            ensure  => latest;
        "libpq-dev":
            ensure  => latest;
    }

    exec {"/usr/bin/createdb observatory -E UTF8 -l en_US.UTF8 -T template0":
        user    => "postgres",
        unless  => "/usr/bin/psql -l | /bin/grep observatory",
        require => Package["postgresql-9.1"],
        returns => [0, 1],
    }

    exec {"/usr/bin/psql -c \"ALTER USER postgres PASSWORD 'zaq12wsxcde34rfv'\"":
        user    => "postgres",
        require => Package["postgresql-9.1"],
        subscribe => Package["postgresql-9.1"],
        refreshonly => true,
    }
}
