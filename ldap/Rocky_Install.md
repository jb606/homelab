yum install epel-release

yum install openldap-servers openldap-clients
Place your server certs (.crt, .key, and chain) in /etc/openldap/certs
chmod 600 /etc/openldap/certs/{ chain.crt, server.crt }
chmod 400 /etc/openldap/certs/server.key # protect the private key from modification

I'm going to use dc=home,dc=lab (home.lab)

slapadd -n 0 -F /etc/openldap/slapd.d/ -l basecfg.ldif
slapadd -n0 -F /etc/openldap/slapd.d -l /etc/openldap/schema/core.ldif
slapadd -n0 -F /etc/openldap/slapd.d -l /etc/openldap/schema/cosine.ldif
slapadd -n0 -F /etc/openldap/slapd.d -l /etc/openldap/schema/inetorgperson.ldif
slapadd -n0 -F /etc/openldap/slapd.d -l /etc/openldap/schema/nis.ldif
slapadd -n0 -F /etc/openldap/slapd.d -l /usr/share/doc/sudo/schema.olcSudo
slapadd -n0 -F /etc/openldap/slapd.d/ -l db.ldif


mkdir -p /var/run/openldap
chown -R ldap:ldap /etc/openldap/slapd.d /var/run/openldap /etc/openldap/certs/*

restorecon -Rv /etc/openldap
systemctl enable --now slapd

Update TLS settings in tls.ldif
ldapmodify -Y EXTERNAL -H ldapi:/// -f tls.ldif