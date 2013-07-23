class observatory {
    require "observatory::dir"

    class {"observatory::ps":}
    class {"observatory::fetch":}

    package {
        "python-pip":
            ensure  => latest;
        "git":
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
        alias   => "install"
    }

    exec {"/var/www/Observatory/observatory/manage.py syncdb --noinput":
        require => Exec["install"],
        alias   => "db0",
        user    => "www-data"
    }

    exec {"/var/www/Observatory/observatory/manage.py migrate dashboard --noinput":
        require => Exec["db0"],
        alias   => "db1",
        user    => "www-data"
    }

    exec {"/var/www/Observatory/observatory/manage.py migrate todo --noinput":
        require => Exec["db1"],
        alias   => "db2",
        user    => "www-data"
    }
}
