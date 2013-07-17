class observatory {
    class{ "observatory::ps":}
    class{ "observatory::fetch":}
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

    file {"/var/www/Observatory/observatory/media/style.css":
        ensure  => present,
        mode    => 0777
    }

    file {"/var/www/Observatory/observatory/media/observatory.js":
        mode    => 0777
    }
}
