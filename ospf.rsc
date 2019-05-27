# may/27/2019 18:47:25 by RouterOS 6.43.13
# software id = FIE3-Y5J9
#
# model = 2011UiAS-2HnD r2
# serial number = 91DE092C453F
/routing ospf interface
add authentication=none authentication-key="" authentication-key-id=1 cost=10 \
    dead-interval=40s disabled=no hello-interval=10s instance-id=0 interface=\
    loopback network-type=broadcast passive=no priority=1 \
    retransmit-interval=5s transmit-delay=1s use-bfd=no
