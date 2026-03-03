Notes:

openssl genrsa -out labserver.key 2048

openssl req -new -sha384 -key labserver.key -subj "/C=US/ST=PA/O=Example Lab/CN=labserver.a.lab" -addext "subjectAltName=DNS:labserver.a.lab,DNS:labserver,IP:10.10.10.14" -out labserver.csr

openssl ca -config ../intermediate/openssl.cnf -extensions server_cert -days 730 -notext -md sha384 -in labserver.csr -out labserver.crt

openssl pkcs12 -export -out hex01.p12 -inkey hex01.key -in hex01.crt -certfile ../../chain.crt
