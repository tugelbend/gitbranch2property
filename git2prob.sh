#!/bin/bash
#This script creates a property file with all branches available in a git repository
#The proberty file can be used f.e. by jenkins to give the option which branch to use 
#for a build.
#
#It is recommended to use this script with cron, so the properties file is updated as
#new branches appear (or old ones disappear) in the repo.
#
#USAGE: sh git2prop.sh [Path or URL to git repository] [Path to properties file]

#leave script if mandatory arguments not present
if [ -z "$1" ] || [ -z "$2" ]; then
	echo usage: $0 path-to-repository path-to-properties-file
	exit
fi

REPO=$1
PROPFILE=$2

if [ -z $PROPFILE ]; then
        rm $PROPFILE
fi

#create a valid temporary property file
echo -ne 'branches=' > ${PROPFILE}.tmp

#we need 'origin' instead of 'ref/heads'
/usr/bin/git ls-remote -h $REPO | /usr/bin/awk '{print $2}' | /usr/bin/sed s%^refs/heads%origin% >> ${PROPFILE}.tmp

#jenkins can not handle newlines as seperators
/usr/bin/tr '\n' ',' < ${PROPFILE}.tmp > $PROPFILE

#cleanup
rm ${PROPFILE}.tmp
