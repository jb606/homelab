Notes:

Example: (using /opt/ca as the base)

openssl genrsa -out root/private/root-ca.key.pem 4096
openssl req -config root/openssl.cnf -key root/private/root-ca.key.pem -new -x509 -days 7300 -sha384 -out root/certs/root-ca.cert.pem

openssl genrsa -out intermediate/private/intermediate-ca.key.pem 4096



openssl genrsa -out labserver.key 2048
openssl req -new -sha384 -key labserver.key -subj "/C=US/ST=PA/O=Example Lab/CN=labserver.a.lab" -addext "subjectAltName=DNS:labserver.a.lab,DNS:labserver,IP:10.10.10.14" -out labserver.csr

openssl ca -config ../intermediate/openssl.cnf -extensions server_cert -days 730 -notext -md sha384 -in labserver.csr -out labserver.crt

openssl pkcs12 -export -out hex01.p12 -inkey hex01.key -in hex01.crt -certfile ../../chain.crt
