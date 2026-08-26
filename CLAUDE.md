# CLAUDE.md — AcreetionOS Proxmox Image

## Overview

AcreetionOS Proxmox Image is an auto-installing Arch Linux-based server ISO with a full
Cinnamon desktop experience, tuned for Proxmox VE virtual machines: qemu-guest-agent
enabled out of the box, virtio disk preference in the installer, serial console wired up,
and the wireless/audio stacks omitted (VMs have neither). On first boot, it asks whether
you want to keep the GUI or strip to TTY-only mode — like Windows Server with Desktop
Experience, but with a choice.

## Key Concepts

### Auto-Installation
The ISO boots, auto-partitions the first available disk, installs everything,
and reboots. Zero interaction required.

### First-Boot Wizard
On first boot after installation, a wizard (`acreetionos-firstboot`) runs and asks:
- **Keep GUI**: Full Cinnamon desktop + server tools
- **Strip to TTY**: Removes ~500MB of desktop packages, switches to multi-user.target

This is reversible:
- `sudo acreetionos-strip-gui` — remove GUI anytime
- `sudo acreetionos-install-gui` — reinstall GUI anytime

### Maintenance Tool
`sudo acreetionos-maintain` — one-stop shop for:
- System updates, cache cleaning, orphan removal
- Log inspection, SMART health, disk usage (ncdu)
- Firewall config (nftables), auto-update timers
- Docker management, SSL cert checks, DB status
- Network diagnostics, installed package overview

### Default Credentials
Passwords are generated at install time (32-char random). Displayed on screen
and saved to `/root/.credentials.txt` on the installed system. **Nothing is
hardcoded in the repository.**

### User Model (IAM-like)
Six dedicated users with group-based permissions — use the right user:
- `admin` (wheel,docker,libvirt) — full admin, sudo requires password
- `dbadmin` (postgres,mysql) — database operations, no sudo needed
- `webadmin` (http) — web server management, no sudo needed
- `ops` (docker,libvirt,journal) — containers + monitoring, no sudo needed
- `backup` (storage) — backup tools, no sudo needed
- `root` — everything, use sparingly

## Build Commands

- **Full build**: `./build.sh` — cleans and builds ISO
- **Manual build**: `./mkarchiso.sh` — runs mkarchiso directly
- **Clean workspace**: `./refresh.sh` — removes work/ and out/

## Architecture

### Live ISO Components (airootfs/)
- `usr/local/bin/acreetionos-server-installer` — auto-install script
- `usr/local/bin/acreetionos-server-display` — tty1 status display
- `etc/systemd/system/acreetionos-server-installer.service` — triggers installer
- `etc/systemd/system/getty@tty1.service.d/autologin.conf` — root autologin

### Installed System Components (deployed by installer)
- `usr/local/bin/acreetionos-firstboot` — first-boot wizard (zenity/whiptail)
- `usr/local/bin/acreetionos-strip-gui` — removes desktop, drops to TTY
- `usr/local/bin/acreetionos-install-gui` — reinstalls desktop
- `usr/local/bin/acreetionos-maintain` — interactive maintenance tool
- `etc/systemd/system/acreetionos-firstboot.service` — triggers wizard on boot
- `etc/xdg/autostart/acreetionos-firstboot.desktop` — GUI autostart entry

### Package Profile
- **Desktop**: Full Cinnamon with all applets, themes, icons, fonts
- **Display**: Xorg + Mesa + Vulkan + AMD/Intel/Nvidia drivers
- **Audio**: PipeWire + PulseAudio + ALSA
- **Services**: NetworkManager, OpenSSH, Docker, libvirt, chrony
- **Servers**: nginx, apache, mariadb, postgresql, redis, prometheus, grafana
- **Dev**: base-devel, git, go, rust, nodejs, python
- **Maintenance**: btop, ncdu, htop, tmux, screen, nftables, pkgfile, arch-audit
- **Backup**: restic, borg, timeshift, testdisk, ddrescue, fsarchiver
