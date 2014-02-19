#!/bin/bash
#This script creates a property file with all branches and/or all tags available in a git 
#repository. The property file can be used f.e. by jenkins to give the option which branch 
#or tag to use for a build.
#
#It is recommended to use this script with cron, so the properties file is updated as
#new branches appear (or old ones disappear) in the repo. Using bash is recommended as well,
#as the script might have issues with sh.
#
#USAGE: sh git2prop.sh [-t] [-b] [-p property-file] [-r git-repository]
# [-t] if specified tags will be added to the 'tags' property 
# [-T filter-string] specified string will be used as prefix to filter tags
# [-b] if specified branches will be added to the 'branches' property
# [-B filter-string] specified string will be used as prefix to filter branches
# [-p property-file] path to the property file to create/update
# [-r repository] URL or path to the git repository

REPO=
PROPFILE=
ADDBRANCHES=0
ADDTAGS=0
TPREFIX=""
BPREFIX=""

while getopts ":tbT:B:p:r:" opt; do
  case $opt in
    r)
	  REPO=$OPTARG
	  ;;
	p)
	  PROPFILE=$OPTARG
	  ;;
    b)
	  ADDBRANCHES=1
	  ;;
    t)
      ADDTAGS=1
      ;;
    T)
	  TPREFIX=$OPTARG
	  ;;
	B)
	  BPREFIX=$OPTARG
	  ;;	
    \?)
      echo "Invalid option: -$OPTARG" >&2
      exit 1
      ;;
  esac
done

if [ -z $REPO ] || [ -z PROPFILE ]; then
        echo "usage: $0 [-t] [-b] [-p property-file] [-r git-repository]"
        exit
fi

> ${PROPFILE}

if [ $ADDBRANCHES -gt 0 ]; then
	#create a valid temporary property file
	echo -ne 'branches=' >> ${PROPFILE}
	BFILTER="/refs\/heads\/${BPREFIX}/ {print \$2}"
	#we need 'origin' instead of 'ref/heads'
	/usr/bin/git ls-remote -h $REPO | /usr/bin/awk "${BFILTER}" | /bin/sed s%^refs/heads%origin% | /usr/bin/tr '\n' ',' >> ${PROPFILE}
fi

if [ $ADDTAGS -gt 0 ]; then
	#add tags property for all tags 
	echo -ne '\ntags=' >> ${PROPFILE}
	TFILTER="/refs\/tags\/${TPREFIX}/ {print \$2}"
	#here we only need the 'tags' part before the tag-name
	/usr/bin/git ls-remote -t $REPO | /usr/bin/awk "${TFILTER}" | /bin/sed s%^refs/%% | /usr/bin/tr '\n' ',' >> ${PROPFILE}
fi
