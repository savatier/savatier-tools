#!/bin/bash
set -eu

FS=$1
SH=$2

if [ -z $FS ]; then
        echo "Filesystem to chroot not set"
        exit 1
fi

if [ -z $SH ]; then
        echo "Shell to chroot with not set"
        exit 1
fi

mkdir -p /var/lib/gntmnt/

if [ ! -e /var/lib/gntmnt/*.gntmnt ]; then # If nobody is in the system then we should mount the needed filesystems
touch /var/lib/gntmnt/$$.gntmnt # Create a temporary file to tell the script that we are inside the system
        echo "No Mount detected, Mounting Necessary Filesystems..."
        mount --types proc /proc ${FS}/proc
        mount --rbind /sys ${FS}/sys
        mount --make-rslave ${FS}/sys
        mount --rbind /dev ${FS}/dev
        mount --make-rslave ${FS}/dev
fi
echo "Chrooting into Gentoo system..."
chroot "${FS}" "${SH}"


# By this point the user has exitted from the Chroot, its time to unmount filesystems - assuming this is the only remaining shell.
rm /var/lib/gntmnt/$$.gntmnt

if [ ! -e /var/lib/gntmnt/*.gntmnt ]; then

        echo "Unmounting Filesystems..."
        umount -l ${FS}/dev{/shm,/pts,}
else
        echo "Other shells chrooted, NOT unmounting filesystems..."
fi 
