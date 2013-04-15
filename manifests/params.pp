class basichost::params {

    # Most base packages are installed with the template, as described here:
    # https://inside.digipen.edu/main/ITTR:Debian_and_Ubuntu_Installation
    # https://inside.digipen.edu/main/ITTR:CentOS/Installation
    # https://inside.digipen.edu/main/ITTR:FreeBSD_Setup

    case $osfamily {
        'Debian': {
            $packages   = ['bash', 'tmux']
            $iface_dir  = '/etc/network'
            $iface_file = 'interfaces'
            $dhclient_directory = '/etc/dhcp'
            $dhclient_file  = 'dhclient.conf'
            $dhclient_hasstatus = false
            $dhclient_start = '/sbin/dhclient'
            $dhclient_stop = '/usr/sbin/killall dhclient'
        }
        'FreeBSD': {
            $packages   = ['bash', 'tmux']
            $iface_dir  = '/etc/rc.conf.d'
            $iface_file = 'interfaces'
            $dhclient_directory = '/etc/'
            $dhclient_file  = 'dhclient.conf'
            $dhclient_hasstatus = true
        }
        default : {
            $packages   = ['bash', 'tmux']
            $iface_file = 'interfaces'
            $iface_dir  = '/etc/network'
            $iface_file = 'interfaces'
            $dhclient_directory = '/etc'
            $dhclient_file  = 'dhclient.conf'
            $dhclient_hasstatus = true
        }
    }

    # Convert this fact into an array for use in the dhclient.conf template
    $interfaces_a = split($interfaces,',')

}
