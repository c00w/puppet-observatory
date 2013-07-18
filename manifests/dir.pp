class observatory::dir ($source = "/vagrant/observatory") {
    file {"/var/www":
        ensure => directory,
        owner   => www-data,
        group   => www-data,
        mode    => 0644,
    }

    file {"/var/www/Observatory/":
        ensure  => "directory",
        owner   => www-data,
        group   => www-data,
        mode    => 0644,
    }

    file {"/var/www/Observatory/observatory":
        ensure  => "directory",
        recurse => true,
        owner   => www-data,
        group   => www-data,
        source  => $source
    }
}
