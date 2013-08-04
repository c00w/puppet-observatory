class observatory::fetch {
    package {
        "git-svn":
            ensure  => latest;
        "anacron":
            ensure  => latest;
    }

    file {"/etc/init/fetch.conf":
        owner   => root,
        mode    => 0644,
        source  => "puppet:///modules/observatory/fetch.conf"
    }

    cron::job{
        'fetch_obs':
            minute      => '0,30',
            hour        => '*',
            date        => '*',
            month       => '*',
            weekday     => '*',
            user        => 'root',
            command     => 'start fetch >> /dev/null',
            environment => ['PATH="/usr/bin:/bin:/sbin"' ],
            require     => Package["anacron"],
    }
}
