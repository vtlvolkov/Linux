#!/bin/bash

show_menu(){
    NORMAL=`echo "\033[m"`
    MENU=`echo "\033[36m"` #Blue
    NUMBER=`echo "\033[33m"` #yellow
    FGRED=`echo "\033[41m"`
    RED_TEXT=`echo "\033[31m"`
    ENTER_LINE=`echo "\033[33m"`
    echo -e "${MENU}*********************************************${NORMAL}"
    echo -e "Welcome to Ubuntu Post Installer Script"
    echo -e "\t\trev 2.0 - 2020-04-22"
    echo -e "${MENU}**${NUMBER} 1)${MENU} Install Atom ${NORMAL}"
    echo -e "${MENU}**${NUMBER} 2)${MENU} Install VS Code ${NORMAL}"
    echo -e "${MENU}**${NUMBER} 3)${MENU} Install Docker ${NORMAL}"
    echo -e "${MENU}**${NUMBER} 4)${MENU} Install Submlime Text ${NORMAL}"
    echo -e "${MENU}**${NUMBER} 5)${MENU} Install Gitkraken ${NORMAL}"
    echo -e "${MENU}**${NUMBER} 6)${MENU} Install Google Chrome ${NORMAL}"
    echo -e "${MENU}**${NUMBER} 7)${MENU} Install Skype ${NORMAL}"
    echo -e "${MENU}**${NUMBER} 8)${MENU} Install .NET Core ${NORMAL}"
    echo -e "${MENU}**${NUMBER} 9)${MENU} Install Metasploit Framework ${NORMAL}"
    echo -e "${MENU}**${NUMBER} 10)${MENU} Install Aircrack-NG ${NORMAL}"
    echo -e "${MENU}**${NUMBER} 11)${MENU} Install Misc Apps ${NORMAL}"
    echo -e "${MENU}**${NUMBER} 12)${MENU} Install All ${NORMAL}"
    echo -e "${MENU}*********************************************${NORMAL}"
    echo -e "${ENTER_LINE}Please enter a menu option and enter or ${RED_TEXT}enter to exit. ${NORMAL}"
    read opt
}

function option_picked() {
    COLOR='\033[01;31m' # bold red
    RESET='\033[00;00m' # normal white
    MESSAGE=${@:-"${RESET}Error: No message passed"}
    echo -e "${COLOR}${MESSAGE}${RESET}"
}


function atom_install() {
  curl -L https://packagecloud.io/AtomEditor/atom/gpgkey | sudo apt-key add -
  sudo sh -c 'echo "deb [arch=amd64] https://packagecloud.io/AtomEditor/atom/any/ any main" > /etc/apt/sources.list.d/atom.list'
  sudo apt-get update
	sudo apt-get -y install atom
}

function code_install() {
	curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
  sudo install -o root -g root -m 644 packages.microsoft.gpg /usr/share/keyrings/
  sudo sh -c 'echo "deb [arch=amd64 signed-by=/usr/share/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list'
  sudo apt-get install apt-transport-https
  sudo apt-get update
  sudo apt-get -y install code
  sudo rm -f packages.microsoft.gpg*
}

function docker_install() {
	sudo apt-get -y remove docker docker-engine docker-ce docker-ce-cli docker.io
  sudo apt-get update
  sudo apt-get -y install apt-transport-https ca-certificates curl software-properties-common
  curl -L https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
  sudo sh -c 'echo "deb [arch=amd64] https://download.docker.com/linux/ubuntu/ eoan stable" > /etc/apt/sources.list.d/docker.list'
  sudo apt-get update
  sudo apt-get -y install docker-ce docker-ce-cli containerd.io
}

function sublimetext_install() {
	wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | sudo apt-key add -
  sudo sh -c 'echo "deb https://download.sublimetext.com/ apt/stable/" > /etc/apt/sources.list.d/sublime-text.list'
  sudo apt-get update
  sudo apt-get -y install sublime-text
}

function gitkraken_install() {
  wget https://release.gitkraken.com/linux/gitkraken-amd64.deb
  sudo dpkg -i gitkraken-amd64.deb
  sudo rm -f gitkraken-amd64.deb*
}

function chrome_install() {
  wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
  sudo sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" > /etc/apt/sources.list.d/google-chrome.list'
  sudo apt-get -y install ./google-chrome-stable_current_amd64.deb
  sudo rm -f google-chrome-stable_current_amd64.deb
}

function skype_install() {
  sudo dpkg --add-architecture i386
  sudo apt-get update
  wget -O skype-install.deb http://www.skype.com/go/getskype-linux-deb
  sudo apt-get -f install
  sudo dpkg -i skype-install.deb
  sudo rm -f skype-install.deb*
}

function dotnetcore_install() {
  wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.asc.gpg
  sudo mv microsoft.asc.gpg /etc/apt/trusted.gpg.d/
  wget -q https://packages.microsoft.com/config/ubuntu/19.10/prod.list
  sudo mv prod.list /etc/apt/sources.list.d/microsoft-prod.list
  sudo chown root:root /etc/apt/trusted.gpg.d/microsoft.asc.gpg
  sudo chown root:root /etc/apt/sources.list.d/microsoft-prod.list
  sudo apt-get update
  sudo apt-get -y install apt-transport-https
  sudo apt-get update
  sudo apt-get -y install dotnet-sdk-3.1 aspnetcore-runtime-3.1 dotnet-runtime-3.1
  sudo rm -f packages.microsoft.gpg*

  sudo apt -y install gnupg ca-certificates
  sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 3FA7E0328081BFF6A14DA29AA6A19B38D3D831EF
  echo "deb https://download.mono-project.com/repo/ubuntu stable-bionic main" | sudo tee /etc/apt/sources.list.d/mono-official-stable.list
  sudo apt update
  sudo apt -y install mono-devel
}

function msfconsole_install() {
  curl https://raw.githubusercontent.com/rapid7/metasploit-omnibus/master/config/templates/metasploit-framework-wrappers/msfupdate.erb > msfinstall && \
  chmod 755 msfinstall && \
  ./msfinstall
  sudo rm -f msfinstall
}

function aircrackng_install() {
  sudo apt-get -y install build-essential autoconf automake libtool pkg-config libnl-3-dev libnl-genl-3-dev libssl-dev ethtool shtool rfkill zlib1g-dev libpcap-dev libsqlite3-dev libpcre3-dev libhwloc-dev libcmocka-dev hostapd wpasupplicant tcpdump screen iw usbutils
  sudo apt-get -y install aircrack-ng
}

function misc_install() {
  sudo apt-get -y install openconnect network-manager-openconnect network-manager-openconnect-gnome nmap hashcat tshark reaver pyrit gqrx-sdr xterm sslstrip john ettercap-graphical mdk4 lighttpd dhcpd dsniff crunch php hydra cutycapt python3-pip python3-distutils
}


function init_function() {
clear
show_menu
while [ opt != '' ]
    do
    if [[ $opt = "" ]]; then
            exit;
    else
        case $opt in
        1) clear;
        	option_picked "Installing Atom";
		atom_install;
		option_picked "Operation Done!";
        	exit;
        ;;

        2) clear;
		option_picked "Installing Visual Studio Code";
		code_install;
		option_picked "Operation Done!";
		exit;
            ;;

        3) clear;
		option_picked "Installing Docker";
		docker_install;
		option_picked "Operation Done!";
		exit;
            ;;

        4) clear;
		option_picked "Installing Sublime Text";
		sublimetext_install;
		option_picked "Operation Done!";
		exit;
            ;;
	5) clear;
		option_picked "Installing Gitkraken";
		gitkraken_install;
		option_picked "Operation Done!";
		exit;
		;;
  6) clear;
  	option_picked "Installing Google Chrome";
  	chrome_install;
  	option_picked "Operation Done!";
  	exit;
  	;;
  7) clear;
  	option_picked "Installing Skype";
  	skype_install;
  	option_picked "Operation Done!";
  	exit;
  	;;
  8) clear;
		option_picked "Installing .NET Core";
		dotnetcore_install;
		option_picked "Operation Done!";
		exit;
		;;
  9) clear;
		option_picked "Installing Metasploit Console";
		msfconsole_install;
		option_picked "Operation Done!";
		exit;
		;;
  10) clear;
		option_picked "Installing Airckrack-NG";
		aircrackng_install;
		option_picked "Operation Done!";
		exit;
		;;
  11) clear;
		option_picked "Installing Misc Apps";
		misc_install;
		option_picked "Operation Done!";
		exit;
		;;
	12) clear;
		option_picked "Installing All";
		    atom_install;
    		code_install;
        docker_install;
        sublimetext_install;
        gitkraken_install;
        chrome_install;
        skype_install;
        dotnetcore_install;
        msfconsole_install;
        aircrackng_install;
        misc_install;
		option_picked "Operation Done!";
		exit;
	    ;;
        x)exit;
        ;;

	q)exit;
	;;

        \n)exit;
        ;;

        *)clear;
        option_picked "Pick an option from the menu";
        show_menu;
        ;;
    esac
fi
done
}

if [ `whoami` == "root" ]; then
	init_function;
else
	echo "R U Drunk? This script needs to be run as root!"
fi
