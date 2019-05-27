# CONFIGURACIÓ CABLEJADA R1

Seguidament farem una explicació de la configuració de R1 amb la següent informació

```
# may/14/2019 09:20:15 by RouterOS 6.43.13
# software id = FIE3-Y5J9
#
# model = 2011UiAS-2HnD r2
# serial number = 91DE092C453F
```
## Bridges

```
/interface bridge
add name=bridge
add name=loopback
```
## Interfaces

```
/interface ethernet
set [ find default-name=ether1 ] speed=100Mbps
set [ find default-name=ether2 ] speed=100Mbps
set [ find default-name=ether3 ] speed=100Mbps
set [ find default-name=ether4 ] speed=100Mbps
set [ find default-name=ether5 ] speed=100Mbps
set [ find default-name=ether6 ] advertise=\
    10M-half,10M-full,100M-half,100M-full,1000M-half,1000M-full
set [ find default-name=ether7 ] advertise=\
    10M-half,10M-full,100M-half,100M-full,1000M-half,1000M-full
set [ find default-name=ether8 ] advertise=\
    10M-half,10M-full,100M-half,100M-full,1000M-half,1000M-full
set [ find default-name=ether9 ] advertise=\
    10M-half,10M-full,100M-half,100M-full,1000M-half,1000M-full
set [ find default-name=ether10 ] advertise=\
    10M-half,10M-full,100M-half,100M-full,1000M-half,1000M-full
```
## VPLS
```
/interface vpls
add disabled=no l2mtu=1504 mac-address=02:95:BC:84:86:C0 name=vpls-R1R2 \
    remote-peer=2.2.2.2 vpls-id=1:2
add disabled=no l2mtu=1504 mac-address=02:95:BC:84:86:C0 name=vpls-R1R3 \
    remote-peer=3.3.3.3 vpls-id=1:3
add disabled=no l2mtu=1504 mac-address=02:95:BC:84:86:C0 name=vpls-R1R4 \
    remote-peer=4.4.4.4 vpls-id=1:4
```
## VLAN

separar pppoe
```
/interface vlan
add interface=bridge mtu=1496 name=vlan10 vlan-id=10
```
## caps-man

```
/caps-man configuration
add channel.band=2ghz-g/n channel.tx-power=-30 country=spain datapath.bridge=\
    bridge datapath.local-forwarding=yes datapath.vlan-id=10 \
    datapath.vlan-mode=use-tag mode=ap name="2.4GHz PPPoE" ssid=\
    "TFG 2.4GHz PPPoE"
add channel.tx-power=-15 country=spain datapath.bridge=bridge \
    datapath.local-forwarding=yes mode=ap name="2.4GHz DHCP" ssid=\
    "TFG 2.4GHz DHCP"
add channel.band=5ghz-a/n/ac country=spain datapath.bridge=bridge \
    datapath.local-forwarding=yes distance=indoors mode=ap name="5GHz DHCP" \
    ssid="TFG 5GHz DHCP"
```

## interface wireless security-profile

```
/interface wireless security-profiles
set [ find default=yes ] supplicant-identity=MikroTik
add authentication-types=wpa-psk,wpa2-psk eap-methods="" \
    management-protection=allowed mode=dynamic-keys name=profile1 \
    supplicant-identity="" wpa-pre-shared-key=ap.081007! wpa2-pre-shared-key=\
    ap.081007!
```

## interface wireless

``
/interface wireless
set [ find default-name=wlan1 ] band=2ghz-b/g/n disabled=no frequency=2437 \
    security-profile=profile1 ssid=apDeuMata
``
## ip pool

```
/ip pool
add name=dhcp_pool1 ranges=172.21.7.10-172.21.7.254
add name=dhcp_pool3 ranges=192.168.5.10-192.168.5.254
```

## dhcp-servers

```
/ip dhcp-server
add address-pool=dhcp_pool1 disabled=no interface=bridge lease-time=10s name=\
    dhcp1
add address-pool=dhcp_pool3 disabled=no interface=vlan10 lease-time=10s name=\
    dhcp2
```

## ppp profile

```
/ppp profile
set *FFFFFFFE remote-address=dhcp_pool3
```
## routing ospf instance

```
/routing ospf instance
set [ find default=yes ] distribute-default=always-as-type-1 \
    redistribute-connected=as-type-1 router-id=1.1.1.1
```

## caps-man manager config

```
/caps-man manager
set enabled=yes
/caps-man manager interface
set [ find default=yes ] forbid=yes
add disabled=no interface=bridge
/caps-man provisioning
add action=create-dynamic-enabled hw-supported-modes=gn master-configuration=\
    "2.4GHz PPPoE" name-format=prefix-identity name-prefix=wlan \
    slave-configurations="2.4GHz DHCP"
add action=create-dynamic-enabled hw-supported-modes=ac master-configuration=\
    "5GHz DHCP" name-format=prefix-identity name-prefix=wlan
```

## interface bridge port

```
/interface bridge port
add bridge=bridge interface=vpls-R1R2
add bridge=bridge interface=vpls-R1R3
add bridge=bridge interface=vpls-R1R4
add bridge=bridge interface=ether8
add bridge=bridge interface=ether7
add bridge=bridge interface=ether6
```

## interface pppoe-sercer

```
/interface pppoe-server server
add disabled=no interface=vlan10 service-name=pppoe-server
```

##ip addresses 

```
/ip address
add address=10.10.0.1/30 interface=ether9 network=10.10.0.0
add address=10.30.0.2/30 interface=ether10 network=10.30.0.0
add address=1.1.1.1 interface=loopback network=1.1.1.1
add address=172.21.7.1/24 interface=bridge network=172.21.7.0
add address=192.168.5.1/24 interface=vlan10 network=192.168.5.0
```

## dhcp client and server

```
/ip dhcp-client
add dhcp-options=hostname,clientid disabled=no interface=wlan1
/ip dhcp-server network
add address=172.21.7.0/24 gateway=172.21.7.1
add address=192.168.5.0/24 gateway=192.168.5.1
add address=192.168.10.0/24 gateway=192.168.10.1
```

## firewall

```
/ip firewall nat
add action=masquerade chain=srcnat src-address=172.21.7.0/24
add action=masquerade chain=srcnat src-address=192.168.5.0/24
add action=masquerade chain=srcnat src-address=10.10.0.0/30
```

## mpls

```
/lcd
set time-interval=hour
/mpls ldp
set enabled=yes lsr-id=1.1.1.1 transport-address=1.1.1.1
/mpls ldp interface
add interface=ether10
add interface=ether9
```
## ppp name
```
/ppp secret
add local-address=10.0.0.1 name=prueba password=prueba profile=\
    default-encryption service=pppoe
    
 ```
 
 ## ospf
```
/routing ospf interface
add interface=loopback network-type=broadcast
/routing ospf network
add area=backbone network=10.30.0.0/30
add area=backbone network=10.10.0.0/30
```
### R1

```
/ip address
add address=1.1.1.1 interface=loopback network=1.1.1.1
```
### R2

```
/ip address
add address=2.2.2.2 interface=loopback network=2.2.2.2
```
### R3
```
/ip address
add address=3.3.3.3 interface=loopback network=3.3.3.3
```
### R4
```
/ip address
add address=4.4.4.4 interface=loopback network=4.4.4.4
```




```
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
```
