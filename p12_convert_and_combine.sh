#!/bin/bash
if [ $# -ne 2 ]; then
    echo "Usage: $0 <path_to_p12_file> <password>"
    exit 1
fi

p12_file=$1
password=$2

openssl_path=$(./determine_openssl1.sh)

# Extract the private key
${openssl_path} pkcs12 -in "$p12_file" -nocerts -out private_key.pem -passin pass:"$password" -passout pass:"$password"

# Convert the private key to RSA format
${openssl_path} rsa -in private_key.pem -out private_key_rsa.pem -passin pass:"$password" -passout pass:"$password"

# Extract the client certificate
${openssl_path} pkcs12 -in "$p12_file" -clcerts -nokeys -out certificate.crt -passin pass:"$password"

# Extract the CA certificate
${openssl_path} pkcs12 -in "$p12_file" -cacerts -nokeys -out ca_certificate.crt -passin pass:"$password"

# Combine client and CA certificates
cat certificate.crt ca_certificate.crt > certificate_combined.crt

echo "Conversion complete. Generated files: private_key.pem, private_key_rsa.pem, certificate.crt, ca_certificate.crt, certificate_combined.crt"
