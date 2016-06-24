#!/bin/bash

mkfs.ext4 /dev/sda1
mkfs.ext4 /dev/sda2

mount /dev/sda2 /mnt/sysimage
mkdir /mnt/sysimage/boot
mkdir /mnt/sysimage/proc
mkdir /mnt/sysimage/sys

mount /dev/sda1 /mnt/sysimage/boot
mount -t proc none /mnt/sysimage/proc
mount -t sysfs none /mnt/sysimage/sys

scp root@192.168.0.189:~/centos7.repo .

cp centos7.repo /etc/yum.repos.d/
cd /etc/yum.repos.d/
mv cdrom.repo cdrom.repo.bak

yum makecache
yum --installroot=/mnt/sysimage group install "Minimal Install"


