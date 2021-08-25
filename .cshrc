set   green="%{\033[0;32m%}"
set    cyan="%{\033[1;36m%}"
set   white="%{\033[0;37m%}"
set     end="%{\033[0m%}"
set theUser=`hostname|cut -d'-' -f1`
set prompt = "${green}"$theUser"@"wrappers:"${cyan}%~${white} $ ${end} "
