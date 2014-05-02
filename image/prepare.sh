#!/bin/bash
set -e
source /build/buildconfig
set -x

## Temporarily disable dpkg fsync to make building faster.
echo force-unsafe-io > /etc/dpkg/dpkg.cfg.d/02apt-speedup

## Prevent initramfs updates from trying to run grub and lilo.
## https://journal.paul.querna.org/articles/2013/10/15/docker-ubuntu-on-rackspace/
## http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=594189
export INITRD=no
mkdir -p /etc/container_environment
echo -n no > /etc/container_environment/INITRD

## Enable Ubuntu Universe and Multiverse.
cp /build/sources.list /etc/apt/sources.list
apt-get update

## Fix some issues with APT packages.
## See https://github.com/dotcloud/docker/issues/1024
#dpkg-divert --local --rename --add /sbin/initctl
#ln -sf /bin/true /sbin/initctl
#not needed as done by mkimage-debootstrap.sh for Debian

## Replace the 'ischroot' tool to make it always return true.
## Prevent initscripts updates from breaking /dev/shm.
## https://journal.paul.querna.org/articles/2013/10/15/docker-ubuntu-on-rackspace/
## https://bugs.launchpad.net/launchpad/+bug/974584
dpkg-divert --local --rename --add /usr/bin/ischroot
ln -sf /bin/true /usr/bin/ischroot

## Install HTTPS support for APT.
$minimal_apt_get_install apt-transport-https

## Upgrade all packages.
apt-get dist-upgrade -y --no-install-recommends

## Fix locale.
#$minimal_apt_get_install language-pack-en
#locale-gen en_US
$minimal_apt_get_install locales
dpkg-reconfigure locales && locale-gen C.UTF-8 && /usr/sbin/update-locale LANG=C.UTF-8

