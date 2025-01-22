# Overview

A collection of Ansible scripts I use for setting up different environments on my workstation. Currently targeted towards Arch & Debian-based desktop systems.

:warning: **NOTICE:** These are in early development and are not intended for production use. Anything in this repo may contain system-breaking errors. Use at your own risk and always review/modify the playbooks before running them. 

## Usage

1. Clone this repository locally
2. Run `setup.sh` to get Ansible and a Python venv setup. 
3. The script will prompt you to run one of the included Ansible scripts. Choose a script.
4. Let Ansible do its thing.
5. Profit.

# Scripts
Summaries of the included scripts

## kali-kvm
This will provision a custom Kali KVM for use with [virt-manager](https://virt-manager.org/) for the purpose of using it for CTF events.

Arch & Debian supported.

**To-do**
- [ ] Dynamically grab the latest stable Kali iso
- [ ] Include additional packages
- [ ] Mac & Windows compatibility
- [ ] Proper testing pipeline
 
**Known Issues**
- [ ] Too many to count at this stage 
