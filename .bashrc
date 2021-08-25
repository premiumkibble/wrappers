
PATH=/usr/games:$PATH
theUser=`hostname|cut -d'-' -f1`
PS1="\[\e[m\]\[\e[31m\]\[\e[m\]\[\e[33m\]\[\e[m\]\[\e[32m\]"$theUser"@"wrappers"\[\e[m\]:\[\e[36m\]\w\[\e[m\]\[\e[32m\]\[\e[m\]\[\e[32;47m\]\[\e[m\] $ "

