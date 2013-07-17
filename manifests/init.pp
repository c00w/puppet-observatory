class observatory {
    package {
        "python-pip":
            ensure  => latest;
        "git":
            ensure  => latest;
    }

    exec {"/usr/bin/pip install -r /var/www/Observatory/observatory/requirements.txt":
        alias => "pip_install"}

    Package["python-pip"] -> Exec["pip_install"]

}
