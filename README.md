# Certificate Converter



## convert_and_combine.sh
### Overview
This script is designed to extract the private key, client certificate, and CA certificate from a PKCS#12 file (commonly known as .pfx or .p12 files) and combine the client and CA certificates into a single file. It automates the process of converting these components into separate files for easier management and deployment in environments that require these components to be individually accessible.

### Prerequisites
OpenSSL@1.1 should be installed and accessible from the command line. The script dynamically determines the OpenSSL path or installs OpenSSL1.1 (on Mac).
The PKCS#12 file for which the extraction is to be performed must be available.

### Usage
Place the scripts in the same directory as the PKCS#12 file.
Run the script by passing the PKCS#12 file as an argument:

```./convert_and_combine.sh <path_to_pfx_file> <password>```

### Output
The script generates the following files in the current directory:

private_key.rsa: The private key extracted from the PKCS#12 file.
certificate.crt: The client certificate extracted from the PKCS#12 file.
certificate_chain.crt: The CA certificate extracted from the PKCS#12 file.
certificate_combined.crt: A combination of the client and CA certificates.

**Use certificate_combined and private_key.rsa for nginx reverse proxies.**