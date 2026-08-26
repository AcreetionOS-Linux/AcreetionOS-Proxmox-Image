# Using Our Tools

AcreetionOS Server comes with **90+ pre-installed tools** across 15 categories.
This is every server maintainer's dream toolkit — curated, categorized, and
ready to use.

## User Model: IAM-like Permissions (No Sudo Required)

Instead of forcing everything through `sudo`, AcreetionOS Server uses
**dedicated user accounts** with group-based permissions — like AWS IAM roles.
Each user has exactly the permissions they need, nothing more.

| User      | Groups                         | Can do without sudo                          |
|-----------|--------------------------------|----------------------------------------------|
| `admin`   | wheel, docker, libvirt, journal | anything (sudo requires password)            |
| `dbadmin` | postgres, mysql                 | manage databases, run mycli/pgcli/psql       |
| `webadmin`| http                            | manage nginx/apache, run certbot             |
| `ops`     | docker, libvirt, journal        | run containers, manage VMs, read logs        |
| `backup`  | storage                         | run restic, borg, timeshift, ddrescue        |
| `root`    | (superuser)                     | everything (use sparingly)                   |

**Log in as the right user:**
```bash
su - admin      # full system administration
su - dbadmin    # database work
su - webadmin   # web server management
su - ops        # containers and operations
su - backup     # backup tasks
```

Or SSH directly:
```bash
ssh admin@<server>
ssh ops@<server>
```

## acreetionos-toolbox — Browse & Launch Everything

## acreetionos-toolbox — Browse & Launch Everything

```bash
sudo acreetionos-toolbox
```

A categorized TUI launcher that lets you browse all installed tools by
category, read descriptions, and launch them directly. Categories:

| Category         | Tools include                                          |
|------------------|--------------------------------------------------------|
| Web Admin        | Cockpit, Cockpit Machines/Podman/Storage               |
| Monitoring       | htop, btop, glances, atop, bottom, procs, netdata      |
| Storage          | ncdu, gdu, duf, dust, testdisk, ddrescue, timeshift    |
| Network          | nmap, tcpdump, iperf3, nethogs, bmon, mtr, dog        |
| Files            | mc, ranger, lf, nnn                                   |
| Modern CLI       | bat, ripgrep, fd, jq, yq, delta, fzf, zoxide, tldr    |
| Logs             | lnav, journalctl                                       |
| Containers       | lazydocker, ctop, docker, docker-compose               |
| Database         | mycli, pgcli, usql, mariadb, postgresql, redis         |
| Security         | lynis, rkhunter, fail2ban, clamav, nftables            |
| Dev              | git, gh, glab, httpie, make, cmake                     |
| Remote           | ssh, mosh, byobu, tmux, screen                         |
| Backup           | restic, borg, timeshift                                |
| Misc             | asciinema, entr, parallel, units, hyperfine, zstd       |

## acreetionos-maintain — The Swiss Army Knife

```bash
sudo acreetionos-maintain
```

This is your one-stop shop for keeping the server healthy. It presents a
numbered menu:

| # | Task                        | What it does                                     |
|---|-----------------------------|--------------------------------------------------|
| 1 | Update system               | `pacman -Syu` — full system upgrade               |
| 2 | Clean package cache         | `paccache -r` — keeps last 2 versions             |
| 3 | Check orphans               | Finds + removes orphaned dependencies             |
| 4 | Check system logs           | Shows recent errors from journald                 |
| 5 | Check disk health           | Runs SMART self-test on all disks                 |
| 6 | Check disk usage            | Launches ncdu for interactive disk analysis       |
| 7 | View running services       | Lists active systemd services                     |
| 8 | View resource usage         | Launches htop for real-time monitoring            |
| 9 | Configure firewall          | Interactive nftables wizard (SSH/HTTP/all/none)  |
| 10 | Set up auto-updates         | Enables a weekly systemd timer for pacman -Syu    |
| 11 | Docker management           | Status check + prune unused data                  |
| 12 | Check SSL certs             | Shows expiry dates for Let's Encrypt certs        |
| 13 | Database maintenance        | Shows status of mariadb, postgresql, redis        |
| 14 | Network diagnostics         | IP, gateway, DNS, ping, traceroute                |
| 15 | Server packages overview    | Lists installed server packages with versions     |

## acreetionos-strip-gui — Remove the Desktop

```bash
sudo acreetionos-strip-gui
```

Removes the Cinnamon desktop, Xorg, LightDM, PipeWire, and related packages.
Switches the system to multi-user.target (TTY-only). Saves approximately
500MB of disk space and reduces memory usage.

**This is reversible.** Run `sudo acreetionos-install-gui` to get the
desktop back.

## acreetionos-install-gui — Reinstall the Desktop

```bash
sudo acreetionos-install-gui
```

Reverses `acreetionos-strip-gui`. Reinstalls Cinnamon, Xorg, LightDM, and
audio packages. Enables lightdm.service and sets graphical.target.

After running this, reboot: `sudo reboot`

## pacman — The Package Manager

AcreetionOS Server uses `pacman` with custom repositories:

- **acreetionos-main** — Our curated main repository (LTS-stable packages)
- **personal** — Additional tools and utilities
- **acur** — AcreetionOS Community User Repository (AUR-compatible)

Usage:
```bash
sudo pacman -Syu          # Full system update
sudo pacman -S package    # Install a package
sudo pacman -Rs package   # Remove a package and its deps
sudo pacman -Qs keyword   # Search installed packages
pacman -Ql package        # List files owned by a package
```

## systemctl — Service Management

```bash
sudo systemctl status docker      # Check if Docker is running
sudo systemctl enable --now nginx  # Enable and start nginx
sudo systemctl disable lightdm    # Disable display manager
sudo systemctl list-units         # List all active services
```

## Quick Reference

| What you want                     | Command                                    |
|-----------------------------------|--------------------------------------------|
| Update everything                 | `sudo acreetionos-maintain` then option 1  |
| Remove the desktop                | `sudo acreetionos-strip-gui`               |
| Get the desktop back              | `sudo acreetionos-install-gui`             |
| Check disk space                  | `ncdu /`                                   |
| Monitor system resources          | `htop` or `btop`                           |
| Check logs for errors             | `journalctl -p 3 -b`                       |
| Check disk health                 | `sudo smartctl -H /dev/sda`                |
| Configure firewall                | `sudo acreetionos-maintain` then option 9  |
| Auto-updates                     | `sudo acreetionos-maintain` then option 10 |
