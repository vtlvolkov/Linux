#!/bin/bash

show_menu(){
    NORMAL=`echo "\033[m"`
    MENU=`echo "\033[36m"` #Blue
    NUMBER=`echo "\033[33m"` #yellow
    FGRED=`echo "\033[41m"`
    RED_TEXT=`echo "\033[31m"`
    ENTER_LINE=`echo "\033[33m"`
    echo -e "${MENU}*********************************************${NORMAL}"
    echo -e "Welcome to Parrot Post Installer Script"
    echo -e "\t\trev 0.2 - 2015-06-10"
    echo -e "${MENU}**${NUMBER} 1)${MENU} Install Atom ${NORMAL}"
    echo -e "${MENU}**${NUMBER} 2)${MENU} Install VS Code ${NORMAL}"
    echo -e "${MENU}**${NUMBER} 3)${MENU} Install Docker ${NORMAL}"
    echo -e "${MENU}**${NUMBER} 4)${MENU} Install Submlime Text ${NORMAL}"
    echo -e "${MENU}**${NUMBER} 5)${MENU} Install Gitkraken ${NORMAL}"
    echo -e "${MENU}**${NUMBER} 6)${MENU} Install All ${NORMAL}"
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
}

function docker_install() {
	sudo apt-get -y remove docker docker-engine docker-ce docker-ce-cli docker.io
  sudo apt-get update
  sudo apt-get -y install apt-transport-https ca-certificates curl software-properties-common
  curl -L https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
  sudo sh -c 'echo "deb [arch=amd64] https://download.docker.com/linux/debian/ buster stable" > /etc/apt/sources.list.d/docker.list'
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

function embedded_install() {
	apt-get -y --force-yes -o Dpkg::Options::="--force-overwrite" install parrot-interface parrot-mini
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
		option_picked "Installing All";
		atom_install;
    		code_install;
        docker_install;
        sublimetext_install;
        gitkraken_install;
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
