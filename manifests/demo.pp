class observatory::demo {
    require observatory

    exec {"/var/www/Observatory/observatory/dashboard/demo.py":
        returns => [0, 1],
    }
}
