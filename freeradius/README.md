yum install freeradius freeradius-utils.x86_64

Copy server certs to /etc/raddb/certs/
Owner/group needs to be root:radiusd.  Freeradius runs as radiusd:radiusd

Parts:
Switch == Authenticator
EUD == Supplicant

Proto:
RADIUS - Communication between RADIUS and Authenticator
EAP - Supplicant to RADIUS for authentication
EAPOL - Encapsulated EAP traffic between Supplicant and Authenticator

                EAP (EAP-TLS or EAP-PEAP)
        <--------------------------------------->
[radius] [---------] [Authenticator] [----------] [Supplicant]
            RADIUS                     EAPOL