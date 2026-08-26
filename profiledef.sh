#!/usr/bin/env bash
# shellcheck disable=SC2034

iso_name="AcreetionOS-Proxmox"
iso_label="acreetionOS_Proxmox_$(date --date="@${SOURCE_DATE_EPOCH:-$(date +%s)}" +%Y%m)"
iso_publisher="Acreetion OS"
iso_application="Acreetion OS Proxmox — auto-installing server ISO tuned for Proxmox VE guests"
iso_version="1.0"
install_dir="arch"
buildmodes=('iso')
bootmodes=('bios.syslinux' 'uefi.grub')
arch="x86_64"
pacman_conf="pacman.conf"
airootfs_image_type="squashfs"
airootfs_image_tool_options=('-comp' 'xz' '-Xbcj' 'x86' '-b' '1M' '-Xdict-size' '1M')
bootstrap_tarball_compression=('zstd' '-c' '-T0' '--auto-threads=logical' '--long' '-19')
file_permissions=(
  ["/etc/shadow"]="0:0:400"
  ["/etc/gshadow"]="0:0:400"
  ["/root"]="0:0:750"
  ["/root/customize_airootfs.sh"]="0:0:755"
  ["/root/.automated_script.sh"]="0:0:755"
  ["/root/.gnupg"]="0:0:700"
  ["/usr/local/bin/acreetionos-server-installer"]="0:0:755"
  ["/usr/local/bin/acreetionos-server-display"]="0:0:755"
  ["/usr/local/bin/acreetionos-firstboot"]="0:0:755"
  ["/usr/local/bin/acreetionos-strip-gui"]="0:0:755"
  ["/usr/local/bin/acreetionos-install-gui"]="0:0:755"
  ["/usr/local/bin/acreetionos-maintain"]="0:0:755"
  ["/usr/local/bin/acreetionos-welcome"]="0:0:755"
  ["/usr/local/bin/acreetionos-toolbox"]="0:0:755"
  ["/usr/local/bin/acreetionos-systemd"]="0:0:755"
  ["/usr/local/bin/acreetionos-wizard"]="0:0:755"
  ["/usr/local/bin/acreetionos-wizard-firewall"]="0:0:755"
  ["/usr/local/bin/acreetionos-wizard-database"]="0:0:755"
  ["/usr/local/bin/acreetionos-wizard-security"]="0:0:755"
  ["/usr/local/bin/acreetionos-wizard-backup"]="0:0:755"
  ["/usr/local/bin/acreetionos-wizard-monitoring"]="0:0:755"
  ["/usr/local/bin/acreetionos-wizard-stacks"]="0:0:755"
  ["/usr/local/bin/acreetionos-wizard-network"]="0:0:755"
  ["/usr/local/bin/acreetionos-wizard-vm"]="0:0:755"
  ["/usr/local/bin/acreetionos-wizard-setup"]="0:0:755"
  ["/usr/local/bin/acreetionos-profile"]="0:0:755"
  ["/usr/local/bin/choose-mirror"]="0:0:755"
  ["/usr/local/bin/Installation_guide"]="0:0:755"
)
