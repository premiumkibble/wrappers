#!/bin/bash
archie="`uname -m`"
wrapUser="`who | grep "console" | cut -d" " -f1`"
existingHome=/Users/$wrapUser/DockerHome/wrappers

workingD=`pwd -P`
scriptD="$0"
fullPath="$workingD/$scriptD"
runningD=`dirname "$fullPath"`
rm -rf /tmp/wrappers
cp -R "$runningD/" /tmp/wrappers
cd /tmp/wrappers
rm -f install.sh
rm -rf .git
mv wrap /usr/local/bin/wrap && chmod +x /usr/local/bin/wrap

if [[ "$archie" == "arm64" ]]; then
    mv -f wrappers-AppleSilicon.sh /usr/local/bin/wrappers && chmod +x /usr/local/bin/wrappers
    rm -f wrappers-Intel.sh
else
    mv -f wrappers-Intel.sh /usr/local/bin/wrappers && chmod +x /usr/local/bin/wrappers
    rm -f wrappers-AppleSilicon.sh
fi

sudo -u $wrapUser mkdir -p /Users/$wrapUser/DockerHome
if [ -d "$existingHome" ]; then
    mv $existingHome $existingHome-BAK-`date|tr " " "-"`
fi
cd ..
chown -R $wrapUser wrappers/ 
sudo -u $wrapUser mv wrappers/ /Users/$wrapUser/DockerHome/wrappers
#cd $WorkingD
rm -rf /tmp/wrappers

echo&&echo "$runningD can be deleted..."&&echo 
echo "To start the container, enter '"wrappers"'."&&echo
exit
