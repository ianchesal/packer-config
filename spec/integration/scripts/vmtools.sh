#!/bin/bash -eux

# From: https://github.com/opscode/bento

case "$PACKER_BUILDER_TYPE" in

virtualbox-iso|virtualbox-ovf)
    mkdir /tmp/vbox
    VER=$(cat /home/vagrant/.vbox_version)
    if [ ! -f "/home/vagrant/VBoxGuestAdditions_$VER.iso" ]; then
        wget "http://download.virtualbox.org/virtualbox/4.3.8/VBoxGuestAdditions_$VER.iso" --output-file="/home/vagrant/VBoxGuestAdditions_$VER.iso"
    fi
    mount -o loop /home/vagrant/VBoxGuestAdditions_$VER.iso /tmp/vbox
    sh /tmp/vbox/VBoxLinuxAdditions.run
    umount /tmp/vbox
    rmdir /tmp/vbox
    rm /home/vagrant/*.iso
    chkconfig --add /etc/init.d/vboxadd
    chkconfig --level 345 vboxadd on
    ;;

vmware-iso|vmware-ovf)
    mkdir /tmp/vmfusion
    mkdir /tmp/vmfusion-archive
    mount -o loop /home/vagrant/linux.iso /tmp/vmfusion
    tar xzf /tmp/vmfusion/VMwareTools-*.tar.gz -C /tmp/vmfusion-archive
    /tmp/vmfusion-archive/vmware-tools-distrib/vmware-install.pl --default
    umount /tmp/vmfusion
    rm -rf  /tmp/vmfusion
    rm -rf  /tmp/vmfusion-archive
    rm /home/vagrant/*.iso
    ;;

*)
    echo "Unknown Packer Builder Type >>$PACKER_BUILDER_TYPE<< selected."
    echo "Known are virtualbox-iso|virtualbox-ovf|vmware-iso|vmware-ovf."
    ;;

esac
