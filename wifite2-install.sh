#!/bin/bash

# Professional Wifite2 Installation Script
# Version: 4.0
# Author: KatzeMau
# License: MIT
# This script comes with ABSOLUTELY NO WARRANTY!

set -euo pipefail  # Exit on any error, undefined variable, or pipe failure

# Configuration
SCRIPT_VERSION="4.0"
SCRIPT_NAME="Wifite2 Professional Installer"
LOG_FILE="/var/log/wifite2-install.log"
TEMP_DIR="/tmp/wifite2-install-$$"
BACKUP_DIR="/opt/wifite2-backup"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Flags
AUTO_SIGNUP=0
VERBOSE=0
SKIP_UPDATES=0

# Function definitions
log() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') - $1" | tee -a "$LOG_FILE"
}

print_header() {
    echo -e "${BLUE}"
    echo "=================================="
    echo "$SCRIPT_NAME v$SCRIPT_VERSION"
    echo "=================================="
    echo -e "${NC}"
}

print_status() {
    echo -e "${GREEN}[INFO]${NC} $1"
    log "INFO: $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
    log "WARNING: $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
    log "ERROR: $1"
}

cleanup() {
    print_status "Cleaning up temporary files..."
    rm -rf "$TEMP_DIR" 2>/dev/null || true
}

check_prerequisites() {
    print_status "Checking prerequisites..."
    
    # Check if running as root
    if [[ $EUID -ne 0 ]]; then
        print_error "This script must be run as root!"
        exit 1
    fi
    
    # Log system information
    log "System Information:"
    log "OS: $(lsb_release -d 2>/dev/null | cut -f2 || echo "Unknown")"
    log "Kernel: $(uname -r)"
    log "Architecture: $(uname -m)"
    log "Script Version: $SCRIPT_VERSION"
    
    # Check internet connectivity
    if ! ping -c 1 google.com &> /dev/null; then
        print_error "No internet connection detected!"
        exit 1
    fi
    
    # Check if running on Debian/Ubuntu
    if ! command -v apt-get &> /dev/null; then
        print_error "This script requires a Debian-based system with apt-get!"
        exit 1
    fi
    
    # Check available disk space (require at least 2GB)
    local available_space=$(df / | awk 'NR==2 {print $4}')
    local required_space=2097152  # 2GB in KB
    
    if [[ $available_space -lt $required_space ]]; then
        print_warning "Low disk space detected. At least 2GB recommended."
        if [[ $AUTO_SIGNUP -eq 0 ]]; then
            read -p "Continue anyway? (y/N): " -n 1 -r
            echo
            if [[ ! $REPLY =~ ^[Yy]$ ]]; then
                print_error "Installation cancelled by user"
                exit 1
            fi
        fi
    fi
    
    print_status "Prerequisites check passed!"
}

create_directories() {
    print_status "Creating necessary directories..."
    mkdir -p "$TEMP_DIR"
    mkdir -p "$BACKUP_DIR"
    mkdir -p "$(dirname "$LOG_FILE")"
}

update_system() {
    if [[ $SKIP_UPDATES -eq 0 ]]; then
        print_status "Updating system packages..."
        export DEBIAN_FRONTEND=noninteractive
        
        apt-get update || { print_error "Failed to update package lists"; exit 1; }
        apt-get dist-upgrade -y || { print_error "Failed to upgrade system"; exit 1; }
    else
        print_warning "Skipping system updates as requested"
    fi
}

install_dependencies() {
    print_status "Installing system dependencies..."
    
    local packages=(
        "git"
        "wget"
        "curl"
        "build-essential"
        "cmake"
        "python3"
        "python3-dev"
        "python3-pip"
        "python3-setuptools"
        "libssl-dev"
        "libz-dev"
        "libcurl4-gnutls-dev"
        "libpcap-dev"
        "libglib2.0-dev"
        "libgcrypt20-dev"
        "flex"
        "yacc"
        "bison"
        "byacc"
        "qtbase5-dev"
        "libssh-dev"
        "libsystemd-dev"
        "qtmultimedia5-dev"
        "libqt5svg5-dev"
        "qttools5-dev"
        "aircrack-ng"
        "reaver"
        "pixiewps"
        "bully"
        "wireshark-common"
        "wireless-tools"
        "macchanger"
        "figlet"
    )
    
    for package in "${packages[@]}"; do
        if ! dpkg -l | grep -q "^ii  $package "; then
            print_status "Installing $package..."
            apt-get install -y "$package" || print_warning "Failed to install $package"
        else
            print_status "$package is already installed"
        fi
    done
}

install_hcxtools() {
    print_status "Installing HCX Tools..."
    cd "$TEMP_DIR"
    
    # Install hcxdumptool
    if [[ ! -d "hcxdumptool" ]]; then
        git clone https://github.com/ZerBea/hcxdumptool.git || { print_error "Failed to clone hcxdumptool"; return 1; }
    fi
    
    cd hcxdumptool
    make clean || true
    make || { print_error "Failed to build hcxdumptool"; return 1; }
    make install || { print_error "Failed to install hcxdumptool"; return 1; }
    cd "$TEMP_DIR"
    
    # Install hcxtools
    if [[ ! -d "hcxtools" ]]; then
        git clone https://github.com/ZerBea/hcxtools.git || { print_error "Failed to clone hcxtools"; return 1; }
    fi
    
    cd hcxtools
    make clean || true
    make || { print_error "Failed to build hcxtools"; return 1; }
    make install || { print_error "Failed to install hcxtools"; return 1; }
    cd "$TEMP_DIR"
}

install_wifite2() {
    print_status "Installing Wifite2..."
    cd "$TEMP_DIR"
    
    if [[ ! -d "wifite2" ]]; then
        # Use kimocoder's fork as it's more actively maintained
        git clone https://github.com/kimocoder/wifite2.git || { print_error "Failed to clone wifite2"; return 1; }
    fi
    
    cd wifite2
    git pull --rebase || print_warning "Failed to update wifite2 repository"
    python3 setup.py install || { print_error "Failed to install wifite2"; return 1; }
    cd "$TEMP_DIR"
    
    # Create symlink for easier access
    if [[ ! -L "/usr/local/bin/wifite" ]] && [[ -f "/usr/local/bin/wifite.py" ]]; then
        ln -sf /usr/local/bin/wifite.py /usr/local/bin/wifite || print_warning "Failed to create wifite symlink"
    fi
}

install_hashcat() {
    print_status "Installing Hashcat..."
    cd "$TEMP_DIR"
    
    if [[ ! -d "hashcat" ]]; then
        git clone https://github.com/hashcat/hashcat.git || { print_error "Failed to clone hashcat"; return 1; }
    fi
    
    cd hashcat
    git submodule update --init || print_warning "Failed to update submodules"
    make || { print_error "Failed to build hashcat"; return 1; }
    make install || { print_error "Failed to install hashcat"; return 1; }
    cd "$TEMP_DIR"
    
    # Install hashcat-utils
    if [[ ! -d "hashcat-utils" ]]; then
        git clone https://github.com/hashcat/hashcat-utils.git || { print_error "Failed to clone hashcat-utils"; return 1; }
    fi
    
    cd hashcat-utils/src
    make || print_warning "Failed to build hashcat-utils"
    cd "$TEMP_DIR"
}

verify_installations() {
    print_status "Verifying installations..."
    
    local tools=("wifite" "hcxdumptool" "hcxpcapngtool" "hashcat" "aircrack-ng" "reaver" "bully")
    local failed=()
    local found=()
    
    for tool in "${tools[@]}"; do
        if command -v "$tool" &> /dev/null; then
            local version=""
            case "$tool" in
                "wifite")
                    version=$(wifite --help 2>&1 | head -1 | grep -oE '[0-9]+\.[0-9]+\.[0-9]+' || echo "unknown")
                    ;;
                "hashcat")
                    version=$(hashcat --version 2>&1 | head -1 | grep -oE 'v[0-9]+\.[0-9]+\.[0-9]+' || echo "unknown")
                    ;;
                "aircrack-ng")
                    version=$(aircrack-ng --help 2>&1 | grep -oE '[0-9]+\.[0-9]+' | head -1 || echo "unknown")
                    ;;
                *)
                    version="installed"
                    ;;
            esac
            print_status "$tool: $(command -v "$tool") ($version)"
            found+=("$tool")
        else
            print_warning "$tool: Not found in PATH"
            failed+=("$tool")
        fi
    done
    
    echo ""
    print_status "Successfully installed tools: ${#found[@]}/${#tools[@]}"
    
    if [[ ${#failed[@]} -gt 0 ]]; then
        print_warning "Missing tools: ${failed[*]}"
        print_warning "You may need to add paths to your PATH environment variable"
        return 1
    fi
    
    print_status "All tools verified successfully!"
    return 0
}

show_usage() {
    echo "Usage: $0 [OPTIONS]"
    echo ""
    echo "Options:"
    echo "  -a, --auto        Auto-approve all prompts"
    echo "  -v, --verbose     Enable verbose output"
    echo "  -s, --skip-updates Skip system updates"
    echo "  -h, --help        Show this help message"
    echo ""
}

parse_arguments() {
    while [[ $# -gt 0 ]]; do
        case $1 in
            -a|--auto)
                AUTO_SIGNUP=1
                shift
                ;;
            -v|--verbose)
                VERBOSE=1
                shift
                ;;
            -s|--skip-updates)
                SKIP_UPDATES=1
                shift
                ;;
            -h|--help)
                show_usage
                exit 0
                ;;
            *)
                print_error "Unknown option: $1"
                show_usage
                exit 1
                ;;
        esac
    done
}

main() {
    # Setup trap for cleanup
    trap cleanup EXIT
    
    # Parse command line arguments
    parse_arguments "$@"
    
    # Initialize
    print_header
    create_directories
    
    # Main installation process
    check_prerequisites
    update_system
    install_dependencies
    install_hcxtools
    install_wifite2
    install_hashcat
    
    # Verification
    if verify_installations; then
        print_status "Installation completed successfully!"
        echo ""
        print_status "You can now run 'wifite' to start using the tool."
        print_status "Log file saved to: $LOG_FILE"
        echo ""
        print_status "Remember: With great power comes great responsibility!"
        print_status "Use these tools only on networks you own or have explicit permission to test."
    else
        print_error "Installation completed with some issues. Check the log file: $LOG_FILE"
        exit 1
    fi
}

# Script entry point
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    main "$@"
fi
