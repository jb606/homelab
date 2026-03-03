mkdir -p ~/pki/leaf
openssl genrsa -out ~/pki/leaf/server.key.pem 2048
chmod 400 ~/pki/leaf/server.key.pem

openssl req -new -sha256 \
  -key ~/pki/leaf/server.key.pem \
  -subj "/C=US/ST=PA/O=Example Lab/CN=app.example.lab" \
  -addext "subjectAltName=DNS:app.example.lab,DNS:app,IP:10.0.0.10" \
  -out ~/pki/leaf/server.csr.pem
