# Configuració R3 Wired
```
# jan/13/1970 21:42:03 by RouterOS 6.43.13
# software id = J2KV-LQXT
#
# model = RouterBOARD 952Ui-5ac2nD
# serial number = 71AF0802AA38
```
## Bridge
```
/interface bridge
add name=bridge
add name=loopback
/interface bridge port
add bridge=bridge interface=vpls-R3R1
/interface wireless cap 
set bridge=bridge discovery-interfaces=bridge enabled=yes interfaces=\
    wlan1,wlan2
```
## Interfícies
```
/interface ethernet
set [ find default-name=ether1 ] advertise=\
    10M-half,10M-full,100M-half,100M-full,1000M-half,1000M-full
set [ find default-name=ether2 ] advertise=\
    10M-half,10M-full,100M-half,100M-full,1000M-half,1000M-full
set [ find default-name=ether3 ] advertise=\
    10M-half,10M-full,100M-half,100M-full,1000M-half,1000M-full
set [ find default-name=ether4 ] advertise=\
    10M-half,10M-full,100M-half,100M-full,1000M-half,1000M-full
set [ find default-name=ether5 ] advertise=\
    10M-half,10M-full,100M-half,100M-full,1000M-half,1000M-full
```
## CAP
```
/interface wireless
# managed by CAPsMAN
# channel: 2412/20-Ce/gn(-30dBm), SSID: TFG 2.4GHz PPPoE, local forwarding
set [ find default-name=wlan1 ] disabled=no ssid=MikroTik
/interface wireless security-profiles
set [ find default=yes ] supplicant-identity=MikroTik
add authentication-types=wpa-psk,wpa2-psk eap-methods="aes" \
    management-protection=allowed mode=dynamic-keys name=paswd-5GHz \
    supplicant-identity="" wpa-pre-shared-key=12345678 wpa2-pre-shared-key=\
    12345678
```
## VPLS
```
/interface vpls
add disabled=no l2mtu=1500 mac-address=02:BE:EC:97:ED:87 name=vpls-R3R1 \
    remote-peer=1.1.1.1 vpls-id=1:3
```
## OSPF
```
/routing ospf instance
set [ find default=yes ] redistribute-connected=as-type-1 router-id=3.3.3.3
/routing ospf interface
add interface=loopback network-type=broadcast
/routing ospf network
add area=backbone network=10.30.0.0/30
add area=backbone network=10.40.0.0/30
```

## IP addresses
```
/ip address
add address=10.30.0.1/30 interface=ether1 network=10.30.0.0
add address=3.3.3.3 interface=loopback network=3.3.3.3
add address=10.40.0.1/30 interface=ether5 network=10.40.0.0
```
## MPLS
```
/mpls ldp
set enabled=yes lsr-id=3.3.3.3 transport-address=3.3.3.3
/mpls ldp interface
add interface=ether1
add interface=ether5
```
## Logs & Info
```
/system identity
set name="hAP - R3"
/system logging
add topics=mpls
add topics=ospf,!debug,!raw
