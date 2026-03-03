BASE_DIR=~/code/homelab/ca
echo "Creating private key for CA "
# Root private key (encrypted)
openssl genrsa -aes256 -out $BASE_DIR/root/private/root-ca.key.pem 4096
chmod 400 $BASE_DIR/root/private/root-ca.key.pem

echo "Self-sign root CA "
# Self-signed root cert
openssl req -config $BASE_DIR/root/openssl.cnf \
  -key $BASE_DIR/root/private/root-ca.key.pem \
  -new -x509 -days 7300 -sha256 \
  -out $BASE_DIR/root/certs/root-ca.cert.pem
chmod 444 $BASE_DIR/root/certs/root-ca.cert.pem

echo "Setting up CRL "
# Optional: create an initial CRL
openssl ca -config $BASE_DIR/root/openssl.cnf -gencrl \
  -out $BASE_DIR/root/crl/root-ca.crl.pem
chmod 444 $BASE_DIR/root/crl/root-ca.crl.pem

echo "Creating private key for intermediate CA"
# Intermediate private key (encrypted)
openssl genrsa -aes256 -out $BASE_DIR/intermediate/private/intermediate-ca.key.pem 4096
chmod 400 $BASE_DIR/intermediate/private/intermediate-ca.key.pem

echo "Getting CSR for intermediate CA "
# Intermediate CSR
openssl req -config $BASE_DIR/intermediate/openssl.cnf \
  -new -sha256 \
  -key $BASE_DIR/intermediate/private/intermediate-ca.key.pem \
  -out $BASE_DIR/intermediate/csr/intermediate-ca.csr.pem

echo "Sigining intermediate CA "
# Sign intermediate with root
openssl ca -config $BASE_DIR/root/openssl.cnf \
  -extensions v3_root_ca \
  -days 3650 -notext -md sha256 \
  -in $BASE_DIR/intermediate/csr/intermediate-ca.csr.pem \
  -out $BASE_DIR/intermediate/certs/intermediate-ca.cert.pem

chmod 444 $BASE_DIR/intermediate/certs/intermediate-ca.cert.pem

echo "Making CA chain "
cat $BASE_DIR/intermediate/certs/intermediate-ca.cert.pem \
    $BASE_DIR/root/certs/root-ca.cert.pem \
  > $BASE_DIR/intermediate/certs/ca-chain.cert.pem
chmod 444 $BASE_DIR/intermediate/certs/ca-chain.cert.pem
