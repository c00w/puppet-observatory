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
        alias   => "db",
    }

    exec {"/var/www/Observatory/observatory/dashboard/demo.py":
        require => Exec["db"],
        returns => [0, 1],
    }
}
