class observatory::ps {
    package {
        "postgresql-9.1":
            ensure  => latest;
        "libpq-dev":
            ensure  => latest;
    }

    exec {"/usr/bin/createdb observatory":
        user    => "postgres",
        require => Package["postgresql-9.1"],
        returns => [0, 1],
    }

    exec {"/usr/bin/psql -c \"ALTER USER postgres PASSWORD 'zaq12wsxcde34rfv'\"":
        user    => "postgres",
        require => Package["postgresql-9.1"],
    }
}
