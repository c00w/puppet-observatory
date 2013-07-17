class observatory::dir {
    file {"/var/www/Observatory/":
        ensure  => "directory",
        mode    => 0644,
        recurse => true,
        owner   => www-data,
        group   => www-data,
        source  => "/vagrant"
    }
}
