class observatory::dir {
    file {"/var/www/Observatory/":
        ensure  => "directory",
        recurse => true,
        owner   => www-data,
        group   => www-data,
        source  => "/vagrant"
    }
}
