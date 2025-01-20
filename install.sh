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

    # Debian family
    apt)
        echo "Installing packages with apt (nodejs, npm)"
        sudo apt-get install -y nodejs npm

        echo "Installing pkg builder from @yao"
        sudo npm install -g @yao-pkg/pkg

        echo "Building executable..."
        pkg -t node14-linux jsfetch.js
        sudo mv -f -v jsfetch /usr/local/bin/jsfetch

        echo "Cleaning up..."   
        sudo npm uninstall -g @yao-pkg/pkg

        #Check if file was made and placed correctly
        if [ "$(ls /usr/local/bin | grep -i jsfetch | wc -l)" -gt 0 ]; then
            echo "Done!"
        else
            echo "Something went wrong. Sorry 'bout that..."
        fi
        ;;

    # OpenSUSE family
    zypper)
        echo "Installing packages with zypper (nodejs, npm)"
        sudo zypper in nodejs npm


        echo "Installing pkg builder from @yao"
        sudo npm install -g @yao-pkg/pkg

        echo "Building executable..."
        pkg -t node14-linux jsfetch.js
        sudo mv -f -v jsfetch /usr/local/bin/jsfetch

        echo "Cleaning up..."
        sudo npm uninstall -g @yao-pkg/pkg

        #Check if file was made and placed correctly
        if [ "$(ls /usr/local/bin | grep -i jsfetch | wc -l)" -gt 0 ]; then
            echo "Done!"
        else
            echo "Something went wrong. Sorry 'bout that..."
        fi
        ;;

    # Fedora Family
    dnf)
        echo "pkg manager is $pkgManager"
        ;;

    # Arch-based, btw
    pacman)
        echo "Installing packages with pacman (nodejs, npm)"
        sudo pacman -S --noconfirm nodejs npm

        echo "Installing pkg builder from @yao"
        sudo npm install -g @yao-pkg/pkg

        echo "Building executable..."
        pkg -t node14-linux jsfetch.js
        sudo mv -f -v jsfetch /usr/local/bin/jsfetch

        echo "Cleaning up..."
        sudo npm uninstall -g @yao-pkg/pkg

        #Check if file was made and placed correctly
        if [ "$(ls /usr/local/bin | grep -i jsfetch | wc -l)" -gt 0 ]; then
            echo "Done!"
        else
            echo "Something went wrong. Sorry 'bout that..."
        fi
        ;;

    # Void Linux, you beautiful nerds... :)
    xbps)
        echo "Installing packages with xbps (nodejs, npm)"
        sudo xbps-install -Sy nodejs

        echo "Installing pkg builder from @yao"
        sudo npm install -g @yao-pkg/pkg

        echo "Building executable..."
        pkg -t node14-linux jsfetch.js
        sudo mv -f -v jsfetch /usr/local/bin/jsfetch

        echo "Cleaning up..."
        sudo npm uninstall -g @yao-pkg/pkg

        #Check if file was made and placed correctly
        if [ "$(ls /usr/local/bin | grep -i jsfetch | wc -l)" -gt 0 ]; then
            echo "Done!"
        else
            echo "Something went wrong. Sorry 'bout that..."
        fi
        ;;

    *)
        echo "Unknown pkg manager"
esac
