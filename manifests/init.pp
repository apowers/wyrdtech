class basichost (
    $packages = $basichost::params::packages,
    $iface_dir = $basichost::params::iface_dir,
    $iface_file = $basichost::params::iface_file,
    $dhclient_directory  = $basichost::params::dhclient_directory,
    $dhclient_file  = $basichost::params::dhclient_file,
    $dhclient_hasstatus = $basichost::params::dhclient_hasstatus,
    $dhclient_start = $basichost::params::dhclient_start,
    $dhclient_stop = $basichost::params::dhclient_stop,
    $resolv_conf = {'domain'=>'','search'=>'','nameservers'=>[]},
    $directories = ['/home'],
    $static_address = {},
) inherits basichost::params {

    # Default file mode
    File { mode => '644', }

    # Base System Packages
    package { $packages: ensure=>present }

    # Network Interfaces
    file { "${iface_dir}/${iface_file}" :
        content => template("basichost/${osfamily}/${iface_file}"),
    }

    file { "${dhclient_directory}/${dhclient_file}" :
        content => template("basichost/dhclient.conf"),
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
    }

    # System Directories
    file { $iface_dir :
        ensure  => 'directory',
    }

    file { $directories :
        ensure  => 'directory',
    }

    # User Environment
    file { '/etc/skel/.inputrc' :
        source => 'puppet:///modules/basichost/inputrc',
    }

    file { '/etc/skel/.bashrc' :
        source => 'puppet:///modules/basichost/bashrc',
    }

    file { '/etc/skel/.profile' :
        source => 'puppet:///modules/basichost/profile',
    }

}
