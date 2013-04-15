class basichost::params {

    # Convert this fact into an array for use in the dhclient.conf template
    $interfaces_a = split($interfaces,',')

    case $osfamily {
        'Debian': {
            $iface_dir  = '/etc/network'
            $iface_file = 'interfaces'
            $dhclient_directory = '/etc/dhcp'
            $dhclient_file  = 'dhclient.conf'
            $dhclient_hasstatus = false
            $dhclient_start = '/sbin/dhclient'
            $dhclient_stop = '/usr/sbin/killall dhclient'
        }
        'FreeBSD': {
            $iface_dir  = '/etc/rc.conf.d'
            $iface_file = 'interfaces'
            $dhclient_directory = '/etc/'
            $dhclient_file  = 'dhclient.conf'
            $dhclient_hasstatus = true
        }
        default : {
            $iface_file = 'interfaces'
            $iface_dir  = '/etc/network'
            $iface_file = 'interfaces'
            $dhclient_directory = '/etc'
            $dhclient_file  = 'dhclient.conf'
            $dhclient_hasstatus = true
        }
    }

}
