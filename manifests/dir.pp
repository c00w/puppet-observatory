class observatory::dir ($source = "/vagrant") {
    file {"/var/www/Observatory/":
        ensure  => "directory",
        recurse => true,
        owner   => www-data,
        group   => www-data,
        source  => $source
    }
}
