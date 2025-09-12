# Wifite2 Professional Installation Script

A comprehensive, professional bash script that installs Wifite2 and all necessary penetration testing tools including hcxtools, hcxdumptool, hashcat, aircrack-ng, and more.

## ⚠️ Legal Disclaimer

**Before using these tools, remember that with great power comes great responsibility.**

These tools are intended for:
- Educational purposes
- Testing your own networks
- Authorized penetration testing with explicit written permission

Unauthorized use of these tools may be illegal in your jurisdiction.

## 🚀 Installation

### Prerequisites
- Debian/Ubuntu-based Linux distribution
- Root privileges (sudo access)
- Internet connection

### Quick Install
```bash
sudo bash wifite2-install.sh
```

### Advanced Usage
```bash
# Auto-approve all prompts
sudo bash wifite2-install.sh --auto

# Skip system updates
sudo bash wifite2-install.sh --skip-updates

# Verbose output
sudo bash wifite2-install.sh --verbose

# Show help
bash wifite2-install.sh --help
```


## 📦 What Gets Installed

### Core Tools
- **Wifite2**: Automated wireless attack framework
- **Aircrack-ng**: WiFi security auditing tools
- **Hashcat**: Advanced password recovery
- **HCXTools & HCXDumpTool**: WiFi packet capture and conversion tools

### Additional Tools
- **Reaver**: WPS attack tool
- **Bully**: Alternative WPS attack tool
- **Pixiewps**: WPS offline attack tool
- **Wireshark**: Network protocol analyzer
- **Macchanger**: MAC address manipulation tool

### System Dependencies
- Build tools (gcc, make, cmake)
- Python 3 development environment
- SSL/TLS libraries
- Network packet capture libraries

## 🔧 Features

- ✅ **Professional Error Handling**: Robust error checking and logging
- ✅ **Dependency Management**: Automatic installation of all required packages
- ✅ **Update Safety**: Optional system update skipping
- ✅ **Comprehensive Logging**: Detailed installation logs
- ✅ **Verification**: Post-installation tool verification
- ✅ **Clean Architecture**: Modular, maintainable code
- ✅ **User-Friendly**: Clear status messages and progress indicators

## 📋 Requirements

### Hardware
- WiFi adapter with monitor mode support
- For best results: Alfa AWUS036ACS or similar

### Software
- Debian-based Linux (Ubuntu, Kali, Debian)
- At least 2GB free disk space
- Active internet connection during installation

## 🔌 WiFi Adapter Setup

If using an Alfa WiFi adapter, you may need to install drivers:

```bash
# For RTL88xxAU chipsets
wget https://github.com/aircrack-ng/rtl8812au/archive/refs/heads/v5.6.4.2.tar.gz
tar -xzf v5.6.4.2.tar.gz
cd rtl8812au-5.6.4.2
make
sudo make install
```

## 🐛 Troubleshooting

### Common Issues

1. **Permission Denied**: Ensure you're running as root/sudo
2. **Network Issues**: Check internet connection
3. **Build Failures**: Install build-essential package first
4. **Driver Issues**: Install appropriate WiFi drivers

### Log Files
Check `/var/log/wifite2-install.log` for detailed installation logs.

## 🤝 Contributing

Feel free to submit issues and enhancement requests!

## 📄 License

This project is licensed under the MIT License - see the LICENSE file for details.

---

**⚠️ Remember: Use these tools responsibly and only on networks you own or have explicit permission to test!**
