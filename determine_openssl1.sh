# Function to check if a command exists
command_exists() {
  command -v "$1" >/dev/null 2>&1
}

# Install OpenSSL if necessary and set the path
if [[ "$OSTYPE" == "darwin"* ]]; then
  # Check for Homebrew, and install if not found
  if ! command_exists brew; then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  fi
  # Install OpenSSL if not installed
  if ! command_exists openssl; then
    brew install openssl@1.1
  fi
  # Adjust for system architecture
  if [[ "$(uname -m)" == "arm64" ]]; then
    openssl_path=/opt/homebrew/opt/openssl@1.1/bin/openssl
  else
    openssl_path=/usr/local/opt/openssl@1.1/bin/openssl
  fi
elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
  # For Ubuntu, ensure OpenSSL is installed
  if ! command_exists openssl; then
    sudo apt-get update && sudo apt-get install openssl -y
  fi
  openssl_path=/usr/bin/openssl
else
  echo "Unsupported OS"
  exit 1
fi

echo ${openssl_path}