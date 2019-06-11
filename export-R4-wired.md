# Configuració R4 Wired
```
# jan/09/1970 21:33:24 by RouterOS 6.43.8
# software id = XH6U-18IB
#
# model = 951Ui-2nD
# serial number = 71A306F8AA36
```
## Bridge
```
/interface bridge
add name=bridge
add name=loopback
/interface bridge port
add bridge=bridge interface=vpls-R4R1
/interface wireless cap
set bridge=bridge discovery-interfaces=bridge enabled=yes interfaces=wlan1
```
## CAP
```
/interface wireless
# managed by CAPsMAN
# channel: 2452/20-Ce/gn(-30dBm), SSID: TFG 2.4GHz PPPoE, local forwarding
set [ find default-name=wlan1 ] disabled=no ssid=MikroTik
```
## VPLS
```
/interface vpls
add disabled=no l2mtu=1500 mac-address=02:FE:92:1C:F4:B6 name=vpls-R4R1 \
    remote-peer=1.1.1.1 vpls-id=1:4
```
/interface wireless security-profiles
set [ find default=yes ] supplicant-identity=MikroTik
## OSPF
```
/routing ospf instance
set [ find default=yes ] redistribute-connected=as-type-1 router-id=4.4.4.4
/routing ospf interface
add interface=ether1 network-type=broadcast
/routing ospf network
add area=backbone network=10.40.0.0/30
add area=backbone network=10.50.0.0/30
```
## IP Addresses
```
/ip address
add address=10.40.0.2/30 interface=ether1 network=10.40.0.0
add address=4.4.4.4 interface=loopback network=4.4.4.4
add address=10.50.0.2/30 interface=ether5 network=10.50.0.0
```
## MPLS
```
/mpls ldp
set enabled=yes lsr-id=4.4.4.4 transport-address=4.4.4.4
/mpls ldp interface
add interface=ether1
add interface=ether5
```
## Logs & Info
```
/system identity
set name="hAp - R4"
/system logging
add action=disk topics=ldp
/system ntp client
set enabled=yes primary-ntp=178.255.228.77 secondary-ntp=178.33.111.48
