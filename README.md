envrpl | envreplace
====================
[![main](https://github.com/GDWR/envrpl/actions/workflows/main.yml/badge.svg)](https://github.com/GDWR/envrpl/actions/workflows/main.yml)

Expand content with environment variables.

Piped from stdin
```bash
export MY_VAR="my value"
echo "Content with $ENV_VAR" | envrpl
```

From a file
```bash
echo "Hello $USER" > file.txt
envrpl < file.txt
```

---

Install
-------
Debian package
```bash
VERSION=0.0.1

# Download the latest release
wget https://github.com/GDWR/envrpl/releases/download/v${VERSION}/envrpl_${VERSION}_amd64.deb

# Install the package
sudo dpkg -i envrpl_${VERSION}_amd64.deb

# Clean up
rm envrpl_${VERSION}_amd64.deb
```

