class observatory {
    require "observatory::dir"

    class {"observatory::ps":}
    class {"observatory::fetch":}

    package {
        "python-pip":
            ensure  => latest;
        "git":
            ensure  => latest;
    }

    exec {"/usr/bin/pip install -r /var/www/Observatory/observatory/requirements.txt":
        require => [
            Package["python-pip"],
            Class["observatory::ps"],
            Class["observatory::dir"],
        ],
        alias   => "install"
    }

    exec {"/var/www/Observatory/observatory/manage.py syncdb --noinput":
        require => Exec["install"],
        alias   => "db0",
    }

    exec {"/var/www/Observatory/observatory/manage.py migrate dashboard --noinput":
        require => Exec["db0"],
        alias   => "db1",
    }

    exec {"/var/www/Observatory/observatory/manage.py migrate todo --noinput":
        require => Exec["db1"],
        alias   => "db2",
    }


    exec {"/var/www/Observatory/observatory/dashboard/demo.py":
        require => Exec["db2"],
        returns => [0, 1],
    }
}
