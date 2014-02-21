gitbranch2property
==================

This script creates a property file with all branches and/or all tags available in a git 
repository. The property file can be used f.e. by jenkins to give the option which branch 
or tag to use for a build.

It is recommended to use this script with cron, so the properties file is updated as
new branches appear (or old ones disappear) in the repo. Using bash is recommended as well,
as the script might have issues with sh.

Note: If the git repository is local, tags will be written ordered by creation date (newest 
	   first). If the repository is remote we can get tags only in alphabetical order.

USAGE: sh git2prop.sh [-t] [-T tag-prefix] [-b] [-b branch-prefix] [-p property-file] [-r git-repository]

 [-t] tags will be added to the 'tags' property (optional) 

 [-T tag-prefix] specified string will be used as prefix to filter tags (optional)
 
 [-b] branches will be added to the 'branches' property (optional)

 [-B branch-prefix] specified string will be used as prefix to filter branches (optional)

 [-p property-file] full path to the property file to create/update

 [-r repository] URL or full path to the git repository
