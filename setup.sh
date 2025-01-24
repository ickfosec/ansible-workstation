#!/bin/bash

# Exit on error
set -e

# Check if venv is installed as a module
check_python_venv() {
    python3 -c "import venv" &>/dev/null
}

# Check if venv is installed as a system package
check_package() {
    dpkg -s python3-venv &>/dev/null || rpm -q python3-venv &>/dev/null
}

# Install venv if missing
install_python3_venv() {
    echo "Checking if python3 venv module is available..."
    if check_python_venv; then
        echo "✅ Python3 venv module is available."
    else
        echo "❌ Python3 venv module is missing. Checking system package..."
        if check_package; then
            echo "✅ python3-venv package is already installed."
        else
            echo "❌ python3-venv package is missing. Installing..."
            if [[ -f /etc/debian_version ]]; then
                sudo apt update && sudo apt install -y python3-venv
            elif [[ -f /etc/redhat-release ]]; then
                sudo dnf install -y python3-venv || sudo yum install -y python3-venv
            else
                echo "Unsupported Linux distribution. Please install python3-venv manually."
                exit 1
            fi
            echo "✅ python3-venv installed successfully."
        fi
    fi
}

# Setup and activate venv
setup_virtualenv() {
    echo "Setting up Python virtual environment..."
    python3 -m venv venv
    source venv/bin/activate
    echo "✅ Virtual environment activated."
}

# Install Ansible
install_ansible() {
    echo "Installing Ansible..."
    pip install --upgrade pip
    pip install ansible
    echo "✅ Ansible installed successfully."
}

# List and run Ansible scripts
run_ansible_playbook() {
    echo "Searching for Ansible playbooks..."
    playbooks=(*/*.yml )
    if [ ${#playbooks[@]} -eq 0 ]; then
        echo "❌ No Ansible playbooks found. Exiting."
        exit 1
    fi
    echo "Available Ansible playbooks:"
    select playbook in "${playbooks[@]}"; do
        if [[ -n "$playbook" ]]; then
            echo "Running $playbook..."
            ansible-playbook "$playbook" --ask-become-pass
            echo "✅ Playbook execution complete."
            break
        else
            echo "Invalid selection. Please choose a valid option."
        fi
    done
}

install_python3_venv
setup_virtualenv
install_ansible
run_ansible_playbook
