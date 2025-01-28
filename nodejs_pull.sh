#!/bin/bash

## Download the things ##
# Pull the slackbuild
wget -N https://slackbuilds.org/slackbuilds/15.0/development/nodejs.tar.gz

# Extract and enter
tar -xzf nodejs.tar.gz && cd nodejs

# Pull the necessary downloads
url="$(cat nodejs.info | grep -i download=)"
url=$(echo $url | cut -d '"' -f 2)
wget -N ${url}

## Check the md5 ##
# Get md5 'should be' from info file
md5Sum="$(cat *.info | grep -i md5sum=)"
md5Sum=$(echo $md5Sum | cut -d '"' -f 2)

# Get md5 of source file
md5SumCheck=$(ls | grep -i tar.gz)
md5SumCheck=$(md5sum $md5SumCheck)

echo $md5SumCheck
echo "$md5Sum node.info comparison"

if grep -q "$md5Sum" <<< "$md5SumCheck"; then
    echo "MD5 is a match"
else
    echo "MD5 does not match, exiting script"
    exit
fi


## Build the things ##
# Run slackbuild script
buildFile=$(ls | grep -i .SlackBuild)
chmod +x $buildFile
./$buildFile

# Lookup output file and run the install script
installFile=$(ls /tmp | grep -i $(cat *.info | grep -i PRGNAM | cut -d '"' -f 2))
cd /tmp && installpkg $installFile