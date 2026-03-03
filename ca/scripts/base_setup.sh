# Root CA (offline)
BASE_DIR=~/code/homelab/ca
if [ ! -d "$BASE_DIR/root" ]; then
  mkdir -p $BASE_DIR/root/{certs,crl,newcerts,private,csr}
  chmod 700 $BASE_DIR/root/private
  touch $BASE_DIR/root/index.txt
  echo 1000 > $BASE_DIR/root/serial
  echo 1000 > $BASE_DIR/root/crlnumber
fi 

if [ ! -d "$BASE_DIR/intermediate" ]; then
# Intermediate CA (online)
  mkdir -p $BASE_DIR/intermediate/{certs,crl,csr,newcerts,private}
  chmod 700 $BASE_DIR/intermediate/private
  touch $BASE_DIR/intermediate/index.txt
  echo 1000 > $BASE_DIR/intermediate/serial
  echo 1000 > $BASE_DIR/intermediate/crlnumber
fi
cat root.cnf | sed  "s|BASE_DIR|$BASE_DIR|g" > $BASE_DIR/root/openssl.cnf
cat int.cnf | sed  "s|BASE_DIR|$BASE_DIR|g" > $BASE_DIR/intermediate/openssl.cnf

