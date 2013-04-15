# The default gateway of the host.
# Only returns the first default gateway

# netstat -rn returns routing information on Linux, BSD, and Windows
# Put that data in an array and find the default gateway from it.
# Note that there may be a lot of extra information as well.
# Linux
# 'Destination     Gateway         Genmask         Flags   MSS Window  irtt Iface'
# FreeBSD
# 'Destination        Gateway            Flags    Refs      Use  Netif Expire'
# Windows
# 'Network Destination        Netmask          Gateway       Interface  Metric'


gateway = nil
case Facter.value("kernel")
when "Linux"   then dest_i = 0 ; gw_i = 1 ; mask_i = 2
when "FreeBSD" then dest_i = 0 ; gw_i = 1 ; mask_i = nil
when "Windows" then dest_i = 0 ; gw_i = 2 ; mask_i = 1
end
routes = %x{netstat -rn}
routes.each_line do |line|
    values=line.split
    if ( values[dest_i] == '0.0.0.0' and values[mask_i] == '0.0.0.0' ) or values[dest_i] == 'default'
        gateway = values[gw_i]
        break
    end
end

Facter.add("default_gateway") { setcode { gateway }}
