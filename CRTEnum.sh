#!/bin/bash

declare -r White="\e[97m"
declare -r Red="\e[31m"
declare -r Green="\e[32m"
declare -r YellowLight="\e[93m"
declare -r Cyan="\e[36m"
declare -r CyanLight="\e[96m"
declare -r End="\e[0m"

declare -r var1='['
declare -r var2=']'
declare -r var3='i'
declare -r var4='<'
declare -r var5='>'
declare -r var6='+'
declare -r var7='-'
declare -r var8='x'
declare -r var9='ERROR!'
declare -r var10='Target:'
declare -r var11='Example:'
declare -r var12='domain.com'
declare -r var13='OK'
declare -r var14='NO exist subdomains'
declare -r var15='Dump Subdomains'
declare -r var16='Enum Subdomains'
declare -r var17='CRTEnum'
declare -r var18='============================================='

function banner(){
    echo -e "$YellowLight"
    echo -e "   __________  ____________                     "
    echo -e "  / ____/ __ \/_  __/ ____/___  __  ______ ___  "
    echo -e " / /   / /_/ / / / / __/ / __ \/ / / / __ \`__ \\"
    echo -e "/ /___/ _, _/ / / / /___/ / / / /_/ / / / / / / "
    echo -e "\____/_/ |_| /_/ /_____/_/ /_/\__,_/_/ /_/ /_/ "
    echo -e "$White$var18$End"
} 

function help(){
    echo ""
    echo -e "$White$var1$YellowLight$var3$White$var2 $Green$var11 $White$var17 -d $Red$var4$White$var12$Red$var5$End"
    echo ""
}

function status(){
    echo -e "$White$var1$Red$var7$White$var2 $White$var10 $Green$domain$End"
    sleep 2
    echo -e "$White$var1$YellowLight$var3$White$var2 $White$var16 $White$var1$Green$var13$White$var2$End"
    sleep 2
}

function check(){
        ch=$(curl -s -X GET "https://crt.sh/?q=$domain" | html2text | grep "Certificates" | awk '{print $2}')
    if [ "$(echo $ch)" == "None" ]; then
        echo -e "$White$var1$Red$var8$White$var2 $Red$var9 $White$var14$End"
        echo ""
        sleep 2
        exit 1
    else
        enum
    fi
}

function enum(){
    echo -e "$White$var1$Green$var6$White$var2 $White$var15 $White$var1$Green$var13$White$var2$End"
    sleep 2
    echo -e "$White$var18$End"
    sc=$(curl -s -X GET "https://crt.sh/?q=$domain" | grep -oP '<TD>.*?</TD>' | grep -v -i -E "style|\*" | sort -u | cut -d\> -f 2 | cut -d\< -f 1)
    echo ""
    echo -e "$Cyan$sc$End"
    echo ""
    echo -e "$White$var18$End"
    echo ""
}

function start(){
    banner
    status
    check
}

while getopts ":d:" arg; do
    case $arg in
        d) domain=$OPTARG;
        ;;
    esac
done

if [ ! -z $domain ]; then
	:
else
	banner
	help
	exit 0
fi

start
