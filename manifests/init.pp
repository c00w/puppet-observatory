class observatory {
    package {
        "python-pip":
            ensure  => latest;
        "git":
            ensure  => latest;
    }

    exec {"/usr/bin/pip install -r /var/www/Observatory/observatory/requirements.txt":
        require => Package["python-pip"],
    }
}
