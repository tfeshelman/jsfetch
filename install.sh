#!/bin/bash

if [ "$(cat /etc/os-release | grep -i arch | wc -l)" -gt 0 ]; then
    echo "OS: Arch-based"
    pkgManager=pacman
elif [ "$(cat /etc/os-release | grep -i opensuse | wc -l)" -gt 0 ]; then
    echo "OS: OpenSUSE-based"
    pkgManager=zypper
elif [ "$(cat /etc/os-release | grep -i fedora | wc -l)" -gt 0 ]; then
    echo "OS: Fedora-based"
    pkgManager=dnf
elif [ "$(cat /etc/os-release | grep -i debian | wc -l)" -gt 0 ]; then
    echo "OS: Debian-based"
    pkgManager=apt
else
    echo "Unfamiliar architecture"
fi

case $pkgManager in

    apt)
        echo "pkg manager is $pkgManager"
        sudo apt-get install -y nodejs npm
        sudo npm install -g @yao-pkg/pkg
        sudo pkg -t node14-linux jsfetch.js
        sudo mv -f -v jsfetch /usr/local/bin/jsfetch   
        sudo npm uninstall -g @yao-pkg/pkg
        echo "Done!"
        ;;
    zypper)
        echo "pkg manager is $pkgManager"
        ;;
    dnf)
        echo "pkg manager is $pkgManager"
        ;;
    pacman)
        echo "pkg manager is $pkgManager"
        sudo "$pkgManager" -S nodejs npm
        ;;
    *)
        echo "Unknown pkg manager"
esac