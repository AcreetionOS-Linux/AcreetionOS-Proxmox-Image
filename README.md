# AcreetionOS Proxmox Image

**AcreetionOS as a Proxmox VE guest, done properly.** An auto-installing,
Arch-based server ISO tuned for life inside Proxmox — boot it in a VM, wait
~10 minutes, and you have a fully configured server that the VE host can
actually see and manage.

Derived from [acreetionos-server](https://github.com/AcreetionOS-Code/acreetionos-server):
same auto-installer, same maintenance tooling, same first-boot GUI choice —
with a VM-lean package set.

## Why a separate variant?

Proxmox guests live different lives than bare-metal boxes:

| Difference | What we do about it |
|------------|---------------------|
| No host audio device | Audio stack omitted; `acreetionos-install-gui` restores it if you keep the GUI |
| Wired virtio NIC only | Wireless stack (iwd/wpa_supplicant/NM-applet) omitted |
| Boot disk is `vda` | Installer prefers virtio disks when picking its target |
| VE host wants guest info | `qemu-guest-agent` installed **and enabled** at install time — correct IP reporting, clean shutdown, freeze/snapshot hooks |
| Serial console use | `console=ttyS0,115200n8` on both live ISO and installed system — xterm.js console works out of the box |

Everything else matches AcreetionOS Server: Cinnamon Desktop Experience
(optional at first boot), the six-user IAM model, `acreetionos-maintain`,
the toolbox, and the full server package lineup (nginx, MariaDB, PostgreSQL,
Redis, Prometheus, Grafana, Docker...).

## Using it

1. Upload the ISO to your Proxmox VE storage.
2. Create a VM: **Type: Linux 6.x**, BIOS or UEFI both work, disk bus
   **VirtIO Block**, NIC **VirtIO** (paravirtualized).
3. Boot with the ISO attached. The installer wipes the first virtio disk and
   installs automatically, then reboots.
4. Detach the ISO. Credentials print on the console at install time and land
   in `/root/.credentials.txt`.
5. First boot asks: keep the desktop GUI, or strip to TTY-only?

> The installer destroys all data on the target disk after a 10-second
> countdown — do not attach disks you care about.

## Build

```bash
./build.sh
```

Output ISO lands in `../ISO/`.

## Mirrors

| Platform | URL |
|----------|-----|
| GitHub (AcreetionOS-Code) | https://github.com/AcreetionOS-Code/AcreetionOS-Proxmox-Image |
| GitHub (spivanatalie64) | https://github.com/spivanatalie64/acreetionos-proxmox |

## License

GPL-3.0 — see [LICENSE](LICENSE).

#KeepLinuxFree #AcreetionOSWillAlwaysBeFree
