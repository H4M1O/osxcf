#!/bin/bash                                                                                                                                     
# Script: Mac OS X Configuration File                                             
# Description: OSXCF is a simple script to personalize your terminal in Mac OS X as H4M1O.
# Version: 1.0.1                                                               
# Date: 26-08-2018                                                               
# Author: Claudio Proietti                                                       
# License: The MIT License (MIT) - Copyright (c) 2018 Claudio Proietti

function main ()
{                                                                                    
    # control if sudo is installed and usable
    sudo echo "Testing sudo!" >> /dev/null
    if [ $? -eq 0 ] ; then
        SU="sudo"
        echo "Sudo installed!!!" >> /dev/null
    else
        SU=""
        echo "Sudo not installed!!!" >> /dev/null
    fi
    
    # This is the main function that show the menu and allows the user to make a choice
    # declared integer for user's choice                                             
    clear                                                                            
    declare -i OPT                                                                   
    while true                                                                       
    do                                                                               
        menu                                                                         
        # read input from keyboard                                                   
        read OPT                                                                     
        if [ "$OPT" -ge 0 -a "$OPT" -le 9 ]                                              
        then                                                                         
            case $OPT in                                                             
                1 )
                base_cfg $SU
                echo -e "$(tput setaf 0)$(tput setab 2)\nBASIC INSTALLATION AND CONFIGURATION (HOMEBREW, BASHRC, VIMRC, TMUX) COMPLETED!$(tput sgr 0)\n"                
                ;;
                2 )
                work_apps $SU
                echo -e "$(tput setaf 0)$(tput setab 2)\nWORK TOOLS INSTALLATION AND CONFIGURATION (NMAP, HTOP, LNAV...) COMPLETED!$(tput sgr 0)\n"                
                ;;
                3 )
                all_apps $SU
                echo -e "$(tput setaf 0)$(tput setab 2)\nBASIC AND WORK TOOLS INSTALLATION AND CONFIGURATION COMPLETED!$(tput sgr 0)\n"                
                ;;
                0 ) clear
                echo -e "$(tput setaf 7)$(tput setab 0)\nThank you for using this script!$(tput sgr 0)\n"
                exit 1
                ;;                                                                   
            esac                                                                     
        else                                                                         
            echo "$OPT"                                                                
            clear                                                                    
            echo -e "$(tput setaf 7)$(tput setab 1)ATTENTION: You have inserted the wrong option!!!$(tput sgr 0)\n"
        fi                                                                           
    done                                                                             
}                              

function menu ()
{ 
    # The scope of this function is only to show the contextual menu                 
    echo "$(tput setaf 3)$(tput bold)Welcome to OSX-C.F. - Linux Configuration Files"
    echo -e "Script created by Claudio Proietti under MIT license$(tput sgr 0)\n"
    echo -e "These are the available options:\n"                                 
    echo "1 - BASIC INSTALLATION AND CONFIGURATION (BASHRC, VIMRC, TOP, TMUX)"
    echo "2 - WORK TOOLS INSTALLATION AND CONFIGURATION (NMAP, HTOP, LNAV...)"
    echo "3 - BASIC AND WORK TOOLS INSTALLATION AND CONFIGURATION (ALL-IN-ONE)"
    echo -e "\n0 - Exit the script\n"                                            
    echo "$(tput setaf 3)Write now the option that you want select and press enter: $(tput sgr 0)"  
}      

function base_cfg ()
{
	# install homebrew
	/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    # copy .bashrc base
    cp .bash_profile ~/.bash_profile
    cp .bashrc ~/.bashrc
	cp .sec_alias ~/.sec_alias
    source ~/.bash_profile
    # install wget
    brew install wget
    # install and configure GIT
    brew install git
    git config --global push.followTags true
    # install and configure VIM
    brew install vim
    cp -r .vim ~/
    cp .vimrc ~/
    cp .plugins_vim ~/
    # install and configure TMUX
    brew install tmux
    cp .tmux.conf ~/
    # Copy Wallpapers
	cp -r Wallpapers ~/Pictures
	# install Cheat.sh client
	curl https://cht.sh/:cht.sh > ~/cht.sh; chmod +x ~/cht.sh
}

function work_apps ()
{
    # install networking and sysadmin tools
    brew install --force bmon tcptrack slurm minicom glances lnav htop
    # install GPG
    brew install install gpg
    # install NMap and ZMap
    brew install --force nmap zmap
	# install virtualenv
	pip install virtualenv
}

function all_apps ()
{
    base_cfg
    work_apps
}

#Call to the main function
main
