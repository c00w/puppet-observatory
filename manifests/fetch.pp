class observatory::fetch {
    package {"git-svn":
        ensure  => latest,
    }

    file {"/etc/init/fetch.conf":
        owner   => root,
        mode    => 0644,
        source  => "puppet:///modules/observatory/fetch.conf"
    }

    cron::job{
        'fetch_obs':
            minute      => '*/3',
            hour        => '*',
            date        => '*',
            month       => '*',
            weekday     => '*',
            user        => 'root',
            command     => 'start fetch',
            environment => ['PATH="/usr/bin:/bin:/sbin"' ];
    }
}
