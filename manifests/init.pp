class observatory {
    require "observatory::dir"

    class {"observatory::ps":}
    class {"observatory::fetch":}

    package {
        "python-pip":
            ensure  => latest;
        "python-dev":
            ensure  => latest;
    }

    exec {"/usr/bin/pip install -r /var/www/Observatory/observatory/requirements.txt":
        require => [
            Package["python-pip"],
            Package["python-dev"],
            Class["observatory::ps"],
            Class["observatory::dir"],
        ],
        subscribe   => Class["observatory::dir"],
        refreshonly => true,
        alias       => "install",
        timeout     => 0,
    }

    exec {"/var/www/Observatory/observatory/manage.py syncdb --noinput":
        cwd         => "/var/www/Observatory/observatory",
        subscribe   => Exec["install"],
        refreshonly => true,
        alias   => "db0",
        user    => "www-data"
    }

    exec {"/var/www/Observatory/observatory/manage.py migrate dashboard --noinput":
        cwd         => "/var/www/Observatory/observatory",
        subscribe   => Exec["db0"],
        refreshonly => true,
        alias   => "db1",
        user    => "www-data"
    }

    exec {"/var/www/Observatory/observatory/manage.py migrate todo --noinput":
        cwd         => "/var/www/Observatory/observatory",
        subscribe   => Exec["db1"],
        refreshonly => true,
        alias   => "db2",
        user    => "www-data"
    }

    exec {"/var/www/Observatory/observatory/manage.py migrate emaillist --noinput":
        cwd         => "/var/www/Observatory/observatory",
        subscribe   => Exec["db2"],
        refreshonly => true,
        alias   => "db3",
        user    => "www-data"
    }

}
