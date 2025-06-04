#!/bin/bash

# Gitty Installation Script
# Installs gitty multi-account git CLI tool

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
NC='\033[0m' # No Color

print_success() {
    echo -e "${GREEN}✅ $1${NC}"
}

print_error() {
    echo -e "${RED}❌ $1${NC}"
}

print_warning() {
    echo -e "${YELLOW}⚠️  $1${NC}"
}

print_info() {
    echo -e "${BLUE}ℹ️  $1${NC}"
}

print_header() {
    echo -e "${PURPLE}🚀 Installing Gitty - Multi-Account Git Manager${NC}"
    echo ""
}

# Main installation function
main() {
    print_header
    
    # Check if running on macOS or Linux
    if [[ "$OSTYPE" != "darwin"* ]] && [[ "$OSTYPE" != "linux-gnu"* ]]; then
        print_error "This installer supports macOS and Linux only"
        exit 1
    fi
    
    # Check if git is installed
    if ! command -v git &> /dev/null; then
        print_error "Git is not installed. Please install git first."
        exit 1
    fi
    
    # Create temporary directory
    TEMP_DIR=$(mktemp -d)
    cd "$TEMP_DIR"
    
    print_info "Downloading gitty..."
    
    # Download the gitty script
    if command -v curl &> /dev/null; then
        curl -fsSL https://raw.githubusercontent.com/liperama-dev/gitty/main/gitty -o gitty
    elif command -v wget &> /dev/null; then
        wget -q https://raw.githubusercontent.com/liperama-dev/gitty/main/gitty -O gitty
    else
        print_error "Neither curl nor wget is available. Please install one of them."
        exit 1
    fi
    
    # Make executable
    chmod +x gitty
    
    # Determine installation directory
    INSTALL_DIR="/usr/local/bin"
    
    # Check if we need sudo
    if [[ ! -w "$INSTALL_DIR" ]]; then
        print_warning "Administrator privileges required for installation"
        sudo mv gitty "$INSTALL_DIR/gitty"
    else
        mv gitty "$INSTALL_DIR/gitty"
    fi
    
    # Verify installation
    if command -v gitty &> /dev/null; then
        print_success "Gitty installed successfully!"
        echo ""
        print_info "Try: gitty help"
        print_info "Quick start: gitty init && gitty use <account> && gitty connect <project>"
    else
        print_error "Installation failed. Please check that $INSTALL_DIR is in your PATH"
        exit 1
    fi
    
    # Cleanup
    cd /
    rm -rf "$TEMP_DIR"
    
    echo ""
    print_success "Installation complete! 🎉"
}

# Run main function
main "$@"
