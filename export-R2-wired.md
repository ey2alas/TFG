# Configuració R2 Wired
```
# may/14/2019 09:40:17 by RouterOS 6.43.13
# software id = 2T3K-S0MA
#
# model = RouterBOARD 952Ui-5ac2nD
# serial number = 71AF080AF0A8
```

## Bridge

```
/interface bridge
add name=bridge
add name=loopback
/interface bridge port
add bridge=bridge interface=vpls-R2R1
/interface wireless cap
set bridge=bridge discovery-interfaces=bridge enabled=yes interfaces=\
    wlan1,wlan2
```
## Interfície
```
/interface ethernet
set [ find default-name=ether1 ] advertise=\
    10M-half,10M-full,100M-half,100M-full,1000M-half,1000M-full comment=\
    "to R1"
set [ find default-name=ether2 ] advertise=\
    10M-half,10M-full,100M-half,100M-full,1000M-half,1000M-full
set [ find default-name=ether3 ] advertise=\
    10M-half,10M-full,100M-half,100M-full,1000M-half,1000M-full
set [ find default-name=ether4 ] advertise=\
    10M-half,10M-full,100M-half,100M-full,1000M-half,1000M-full
set [ find default-name=ether5 ] advertise=\
    10M-half,10M-full,100M-half,100M-full,1000M-half,1000M-full comment=\
    "to R4"
```
## CAPs
```
/interface wireless
# managed by CAPsMAN
# channel: 2452/20-Ce/gn(-30dBm), SSID: TFG 2.4GHz PPPoE, local forwarding
set [ find default-name=wlan1 ] disabled=no ssid=MikroTik
/interface wireless
# managed by CAPsMAN
# channel: 5200/20-eCee/ac(23dBm), SSID: TFG 5GHz DHCP, local forwarding
set [ find default-name=wlan2 ] band=5ghz-a/n/ac disabled=no frequency=auto \
    mode=ap-bridge security-profile=paswd-5GHz ssid=LinkR2R3-5G \
    wireless-protocol=802.11
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
add disabled=no l2mtu=1500 mac-address=02:EF:8B:A7:EC:8D name=vpls-R2R1 \
    remote-peer=1.1.1.1 vpls-id=1:2
```
## OSPF
```
/routing ospf instance
set [ find default=yes ] redistribute-connected=as-type-1 router-id=2.2.2.2
/routing ospf interface
add interface=loopback network-type=broadcast
/routing ospf network
add area=backbone network=10.10.0.0/30
add area=backbone network=10.50.0.0/30
```

## IP addresses
```
/ip address
add address=2.2.2.2 interface=loopback network=2.2.2.2
add address=10.10.0.2/30 interface=ether5 network=10.10.0.0
add address=10.50.0.1/30 interface=ether1 network=10.50.0.0
```
## MPLS
```
/mpls ldp
set enabled=yes lsr-id=2.2.2.2 transport-address=2.2.2.2
/mpls ldp interface
add interface=ether5
add interface=ether1
```
## Logs & Info
```
/system identity
set name="hAp - R2"
/system logging
add topics=mpls
/system ntp client
set enabled=yes primary-ntp=147.156.7.18 secondary-ntp=193.70.90.148
