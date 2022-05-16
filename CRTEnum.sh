#!/bin/bash

declare -r WHITE="\e[97m"
declare -r RED="\e[31m"
declare -r GREEN="\e[32m"
declare -r YELLOW="\e[93m"
declare -r CYAN="\e[36m"
declare -r CYANLIGHT="\e[96m"
declare -r END="\e[0m"

declare -r VAR1='['
declare -r VAR2=']'
declare -r VAR3='i'
declare -r VAR4='<'
declare -r VAR5='>'
declare -r VAR6='+'
declare -r VAR7='-'
declare -r VAR8='x'
declare -r VAR9='ERROR!'
declare -r VAR10='Target:'
declare -r VAR11='Example:'
declare -r VAR12='domain.com'
declare -r VAR13='OK'
declare -r VAR14='NO exist subdomains'
declare -r VAR15='Dump Subdomains'
declare -r VAR16='Enum Subdomains'
declare -r VAR17='CRTEnum'
declare -r VAR18='-============================================-'

function banner(){
    echo -e "$YELLOW"
    echo -e "   __________  ____________                     "
    echo -e "  / ____/ __ \/_  __/ ____/___  __  ______ ___  "
    echo -e " / /   / /_/ / / / / __/ / __ \/ / / / __ \`__ \\"
    echo -e "/ /___/ _, _/ / / / /___/ / / / /_/ / / / / / / "
    echo -e "\____/_/ |_| /_/ /_____/_/ /_/\__,_/_/ /_/ /_/ "
    echo -e "$WHITE$VAR18$END"
} 

function help(){
    echo ""
    echo -e "$WHITE$VAR1$YELLOW$VAR3$WHITE$VAR2 $GREEN$VAR11 $WHITE$VAR17 -d $RED$VAR4$WHITE$VAR12$RED$VAR5$END"
    echo ""
}

function status(){
    echo -e "$WHITE$VAR1$RED$VAR7$WHITE$VAR2 $WHITE$VAR10 $GREEN$DOMAIN$END"
    sleep 2
    echo -e "$WHITE$VAR1$YELLOW$VAR3$WHITE$VAR2 $WHITE$VAR16 $WHITE$VAR1$GREEN$VAR13$WHITE$VAR2$END"
    sleep 2
}

function check(){
        ch=$(curl -skX GET "https://crt.sh/?q=$DOMAIN" | html2text | grep "Certificates" | awk '{print $2}')
    if [ "$(echo $ch)" == "None" ]; then
        echo -e "$WHITE$VAR1$RED$VAR8$WHITE$VAR2 $RED$VAR9 $WHITE$VAR14$END"
        echo ""
        sleep 2
        exit 1
    else
        enum
    fi
}

function enum(){
    echo -e "$WHITE$VAR1$GREEN$VAR6$WHITE$VAR2 $WHITE$VAR15 $WHITE$VAR1$GREEN$VAR13$WHITE$VAR2$END"
    sleep 2
    echo -e "$WHITE$VAR18$END"
    F1=$(curl -skX GET "https://crt.sh/?q=$DOMAIN&output=json" | jq -r '.[] | "\(.name_value)\n\(.common_name)"' | sort -u)
    echo ""
    echo -e "$GREEN$F1$END"
    echo ""
    echo -e "$WHITE$VAR18$END"
    echo ""
}

function start(){
    banner
    status
    check
}

while getopts ":d:" arg; do
    case $arg in
        d) DOMAIN=$OPTARG;
        ;;
    esac
done

if [ ! -z $DOMAIN ]; then
	:
else
	banner
	help
	exit 0
fi

start
