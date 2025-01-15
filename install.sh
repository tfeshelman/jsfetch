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
elif [ "$(cat /etc/os-release | grep -i void | wc -l)" -gt 0 ]; then
    echo "OS: Void"
    pkgManager=xbps
else
    echo "Unfamiliar architecture"
fi

case $pkgManager in

    apt)
        echo "Installing packages with apt (nodejs, npm)"
        sudo apt-get install -y nodejs npm

        echo "Installing pkg builder from @yao"
        sudo npm install -g @yao-pkg/pkg

        echo "Building executable..."
        sudo pkg -t node14-linux jsfetch.js
        sudo mv -f -v jsfetch /usr/local/bin/jsfetch

        echo "Cleaning up..."   
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
        echo "Installing packages with pacman (nodejs, npm)"
        sudo pacman -S --noconfirm nodejs npm

        echo "Installing pkg builder from @yao"
        sudo npm install -g @yao-pkg/pkg

        echo "Building executable..."
        sudo pkg -t node14-linux jsfetch.js
        sudo mv -f -v jsfetch /usr/local/bin/jsfetch

        echo "Cleaning up..."
        sudo npm uninstall -g @yao-pkg/pkg
        echo "Done!"
        ;;

    xbps)
        echo "Installing packages with xbps (nodejs, npm)"
        sudo xbps-install -Sy nodejs

        echo "Installing pkg builder from @yao"
        sudo npm install -g @yao-pkg/pkg

        echo "Building executable..."
        sudo pkg -t node14-linux jsfetch.js
        sudo mv -f -v jsfetch /usr/local/bin/jsfetch

        echo "Cleaning up..."
        sudo npm uninstall -g @yao-pkg/pkg
        echo "Done!"
        ;;
    *)
        echo "Unknown pkg manager"
esac