#!/bin/bash          

CONFIG_FILENAME=$HOME"/.packagesAwaiting/packagesAwaiting.config"

function findPackageVersion(){
        eixOutput=`eix  -c $1`
        [[ $eixOutput =~ \(([^@\)]+) ]] &&
                packageVersionEix=${BASH_REMATCH[1]}
}

#-------main program

while test $# -gt 0; do
        case "$1" in
                -h|--help)
                        echo "packagesAwaiting - simple script to check for newer versions of desired packages"
                        echo " "
                        echo "packagesAwaiting [-a][-h] [category/package]"
                        echo " "
                        echo "options:"
                        echo "-h, --help                show brief help"
                        echo "-a, --add                 adds new package"                        
                        echo "-r, --remove              removes specified package"                        
                        echo "-c, --clear               clear all packages from list"                        
                        echo "-l, --list                prints list of awaiting packages"                        

                        exit 0
                        ;;
                -a|--add)
                        shift
                        if test $# -gt 0; then
                               echo $1 >> $CONFIG_FILENAME
                               echo "Package added: "$1
                               exit 0
                        else
                                echo "No package to add specified"
                                exit 1
                        fi
                        shift
                        ;;
                -r|--remove)
                        shift
                        if test $# -gt 0; then
                               sed -i "/^$1$/d" $CONFIG_FILENAME
                               echo "Package removed: "$1
                               exit 0
                        else
                                echo "No package to add specified"
                                exit 1
                        fi
                        shift
                        ;;

                -c|--clear)
                        > $CONFIG_FILENAME
                        echo "All packages removed."
                        exit 0
                        ;;
                -l|--list)
                        cat  $CONFIG_FILENAME
                        exit 0
                        ;;
                *)
                        echo "Unknown argument. Use -h for help."
                        exit 1
                        ;;
        esac
done

waitingPackages=`wc -l $CONFIG_FILENAME | cut -f 1 -d " "`
found=0
echo "-------- Checking for new packages - total "$waitingPackages" packages will be checked"
while read package #read config file line-by-line
do
  findPackageVersion $package


  if [[ !($packageVersionEix =~ ^[-~]) ]]
    then
     echo -e "\e[00;35mNewer version found for package: "$package"\e[00m"
     found=$((found+1))
   fi
done < $CONFIG_FILENAME
echo "------ Done checking for new packages - new packages found: "$found
