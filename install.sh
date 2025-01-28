#!/bin/bash

# Find the OS and package manager
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
elif [ "$(cat /etc/os-release | grep -i slackware | wc -l)" -gt 0 ]; then
    echo "OS: Slackware"
    pkgManager=installpkg
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

        # Check if file was made and placed correctly
        if [ "$(ls /usr/local/bin | grep -i jsfetch | wc -l)" -gt 0 ]; then
            echo "Done!"
        else
            echo "Something went wrong. Sorry 'bout that..."
        fi
        ;;

    # OpenSUSE family
    zypper)
        echo "Installing packages with zypper (nodejs, npm)"
        sudo zypper -n in nodejs npm


        echo "Installing pkg builder from @yao"
        sudo npm install -g @yao-pkg/pkg

        echo "Building executable..."
        pkg -t node14-linux jsfetch.js
        sudo mv -f -v jsfetch /usr/local/bin/jsfetch

        echo "Cleaning up..."
        sudo npm uninstall -g @yao-pkg/pkg

        # Check if file was made and placed correctly
        if [ "$(ls /usr/local/bin | grep -i jsfetch | wc -l)" -gt 0 ]; then
            echo "Done!"
        else
            echo "Something went wrong. Sorry 'bout that..."
        fi
        ;;

    # Fedora Family
    dnf)
        echo "Installing packages with DNF (nodejs, npm)"
        sudo dnf -y install nodejs npm

        echo "Installing pkg builder from @yao"
        sudo npm install -g @yao-pkg/pkg

        echo "Building executable..."
        pkg -t node14-linux jsfetch.js
        sudo mv -f -v jsfetch /usr/local/bin/jsfetch

        echo "Cleaning up..."
        sudo npm uninstall -g @yao-pkg/pkg

        # Check if file was made and placed correctly
        if [ "$(ls /usr/local/bin | grep -i jsfetch | wc -l)" -gt 0 ]; then
            echo "Done!"
        else
            echo "Something went wrong. Sorry 'bout that..."
        fi
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

        # Check if file was made and placed correctly
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

        # Check if file was made and placed correctly
        if [ "$(ls /usr/local/bin | grep -i jsfetch | wc -l)" -gt 0 ]; then
            echo "Done!"
        else
            echo "Something went wrong. Sorry 'bout that..."
        fi
        ;;

    # Slackware, you even bigger, more beautiful nerds :)
    installpkg)
        
        # Check if node is installed already
        if [ "$(whereis node | grep -i node | wc -w)" -lt 2 ]; then
            echo "Installing packages with installpkg (nodejs, npm)"
            ./nodejs_pull.sh
        fi

        echo "Installing pkg builder from @yao"
        npm install -g @yao-pkg/pkg

        echo "Building executable..."
        pkg -t node14-linux jsfetch.js
        mv -f -v jsfetch /usr/local/bin/jsfetch

        echo "Cleaning up..."
        npm uninstall -g @yao-pkg/pkg

        # Check if file was made and placed correctly
        if [ "$(ls /usr/local/bin | grep -i jsfetch | wc -l)" -gt 0 ]; then
            echo "Done!"
        else
            echo "Something went wrong. Sorry 'bout that..."
        fi
        ;;

    *)
        echo "Unknown pkg manager"
esac
