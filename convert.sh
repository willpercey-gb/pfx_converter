#!/bin/bash

file="$1"
password="$2"

# Check if file variable is empty
if [ -z "$file" ]; then
  echo "Error: No file specified."
  exit 1
fi

openssl_path=$(./determine_openssl1.sh)

# Execute OpenSSL commands
"${openssl_path}" pkcs12 -in "${file}" -nocerts -nodes -out private_key.rsa -passin pass:"$password"
"${openssl_path}" pkcs12 -in "${file}" -clcerts -nokeys -out certificate.crt -passin pass:"$password"
"${openssl_path}" pkcs12 -in "${file}" -cacerts -nokeys -chain -out certificate_chain.crt -passin pass:"$password"