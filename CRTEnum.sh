#!/bin/bash

#colors
White="\e[97m"
GrayDark="\e[90m"
Red="\e[31m"
Green="\e[32m"
YellowLight="\e[93m"
End="\e[0m"

#var
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
declare -r var13='Check Domain'
declare -r var14='NO exist subdomains'
declare -r var15='Subdomains List:'
declare -r var16='Check Subdomains..'
declare -r var17='#'
declare -r var18='###################################################'
declare -r domain="$1"

function banner(){
    echo ""
    echo -e "$White$var18"
    echo -e "$White$var17 $YellowLight   __________  ____________                     $White$var17$End";
    echo -e "$White$var17 $YellowLight  / ____/ __ \/_  __/ ____/___  __  ______ ___  $White$var17$End";
    echo -e "$White$var17 $YellowLight / /   / /_/ / / / / __/ / __ \/ / / / __ \`__ \\ $White$var17$End";
    echo -e "$White$var17 $YellowLight/ /___/ _, _/ / / / /___/ / / / /_/ / / / / / / $White$var17$End";
    echo -e "$White$var17 $YellowLight\____/_/ |_| /_/ /_____/_/ /_/\__,_/_/ /_/ /_/  $White$var17$End";
    echo -e "$White$var17                                                 $White$var17";
    echo -e "$White$var18                                                                           ";
    echo ""
}

function help(){
    echo -e "$White$var1$YellowLight$var3$White$var2 $Green$var11 $White$0 $Red$var4$White$var12$Red$var5$End"
    echo ""
}

function status(){
    echo -e "$White$var1$Red$var7$White$var2 $GrayDark$var10 $Green$domain$End"
    sleep 2
    echo -e "$White$var1$YellowLight$var3$White$var2 $GrayDark$var16$End"
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
    echo -e "$White$var1$Green$var6$White$var2 $GrayDark$var15$End"
    sleep 2
    sc=$(curl -s -X GET "https://crt.sh/?q=$domain" | grep -oP '<TD>.*?</TD>' | grep -v -i -E "style|\*" | sort -u | cut -d\> -f 2 | cut -d\< -f 1)
    echo ""
    echo -e "$Green$sc$End"
    echo ""
}

function start(){
    banner
    status
    check
}

if [ ! -z $domain ]; then
	:
else
	banner
	help
	exit 0
fi

start
