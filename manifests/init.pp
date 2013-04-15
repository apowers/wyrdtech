class basichost (
    $iface_dir          = $basichost::params::iface_dir,
    $iface_file         = $basichost::params::iface_file,
    $dhclient_directory = $basichost::params::dhclient_directory,
    $dhclient_file      = $basichost::params::dhclient_file,
    $dhclient_hasstatus = $basichost::params::dhclient_hasstatus,
    $dhclient_start     = $basichost::params::dhclient_start,
    $dhclient_stop      = $basichost::params::dhclient_stop,
    $packages           = ['bash', 'tmux'],
    $resolv_conf        = {'domain'=>'','search'=>'','nameservers'=>[]},
    $directories        = ['/home'],
    $static_address     = {},
) inherits basichost::params {

    # Base System Packages
    package { $packages: ensure=>present }

    # Network Interfaces
    file { $iface_dir :
        ensure  => 'directory',
        mode => '0644',
    }

    file { "${iface_dir}/${iface_file}" :
        content => template("basichost/${osfamily}/${iface_file}"),
        mode => '0644',
    }

    file { "${dhclient_directory}/${dhclient_file}" :
        content => template("basichost/dhclient.conf"),
        mode => '0644',
    }

    service { 'dhclient':
        ensure      => 'running',
        hasstatus   => $dhclient_hasstatus,
        start       => $dhclient_start,
        stop        => $dhclient_stop,
    }

    # Name Resolution
    file { "/etc/resolv.conf" :
        content => template("basichost/resolv.conf"),
        mode => '0644',
    }

    # System Directories
    file { $directories :
        ensure  => 'directory',
        mode => '0644',
    }

    # User Environment
    file { '/etc/skel/.inputrc' :
        source => 'puppet:///modules/basichost/inputrc',
        mode => '0644',
    }

    file { '/etc/skel/.bashrc' :
        source => 'puppet:///modules/basichost/bashrc',
        mode => '0644',
    }

    file { '/etc/skel/.profile' :
        source => 'puppet:///modules/basichost/profile',
        mode => '0644',
    }

}
