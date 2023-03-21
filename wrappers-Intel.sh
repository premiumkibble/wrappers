#!/bin/bash

ip=`ifconfig en0 | awk '/ *inet /{print $2}'`
if [ -z "$ip" ]; then
        ip=`ifconfig en1 | awk '/ *inet /{print $2}'`
fi
if [ -z "$ip" ]; then
        ip=`ifconfig en2 | awk '/ *inet /{print $2}'`
fi
if [ -z "$ip" ]; then
        ip=`ifconfig en3 | awk '/ *inet /{print $2}'`
fi
if [ -z "$ip" ]; then
        ip=`ifconfig en4 | awk '/ *inet /{print $2}'`
fi

proccheck=`pgrep Docker || echo Nope`
runCheck=`docker ps -a |grep " wrappers"|grep Up`

if [ $proccheck = "Nope" ]; then 
    echo "wrap: Starting Docker..."
    open -a /Applications/Docker.app
    sleep 30
fi
if [ ! -z "$runCheck" ] ; then
    docker stop wrappers
fi

defaults write ~/Library/Preferences/org.macosforge.xquartz.X11.plist nolisten_tcp -bool false
xhost + 127.0.0.1>/dev/null
echo "wrap: Starting container..."
docker pull archimboldi/sosi:wrappers && docker run -d  --rm --hostname `whoami`-wrappers --name wrappers -w /root/myhome -p 127.0.0.1:3389:3389 -e ip=$ip -e DISPLAY=host.docker.internal:0 -v ~/DockerHome/wrappers:/root -v ~/:/root/myhome -v ~/Dockerhome/wrappers/bin:/usr/local/sbin -i -t archimboldi/sosi:wrappers /bin/bash -c 'startup && /bin/bash || /bin/bash' 
exit
