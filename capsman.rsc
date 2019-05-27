# may/27/2019 19:28:11 by RouterOS 6.43.13
# software id = FIE3-Y5J9
#
# model = 2011UiAS-2HnD r2
# serial number = 91DE092C453F
/caps-man configuration
add channel.band=2ghz-g/n channel.tx-power=-30 country=spain datapath.bridge=\
    bridge datapath.local-forwarding=yes datapath.mtu=1492 datapath.vlan-id=\
    10 datapath.vlan-mode=use-tag mode=ap name="2.4GHz PPPoE" ssid=\
    "TFG 2.4GHz PPPoE"
add channel.tx-power=-15 country=spain datapath.bridge=bridge \
    datapath.local-forwarding=yes datapath.mtu=1492 mode=ap name=\
    "2.4GHz DHCP" ssid="TFG 2.4GHz DHCP"
add channel.band=5ghz-a/n/ac channel.frequency=5370 country=spain \
    datapath.bridge=bridge datapath.local-forwarding=yes mode=ap name=\
    "5GHz DHCP" ssid="TFG 5GHz DHCP"
add channel.band=5ghz-a/n/ac country=spain datapath.bridge=bridge \
    datapath.local-forwarding=yes datapath.vlan-id=10 datapath.vlan-mode=\
    use-tag mode=ap name="5GHz DHCP PPPoE" ssid="TFG 5GHz PPPoE"
