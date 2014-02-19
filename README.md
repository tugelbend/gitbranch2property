gitbranch2property
==================

Creating a property file with all branches and/or all tags of a git repository for jenkins parameterized builds

The script is based on the article by Christoph Engelbert: https://www.sourceprojects.org/jenkins-and-the-git-branch-selection

It creates a property file with all branches and/or all tags available in a git repository. The property file can be used f.e. by jenkins to give the option which branch or tag to use for a build.

It is recommended to use this script with cron, so the properties file is updated as new branches appear (or old ones disappear) in the repo. Using bash is recommended as well, as the script might have issues with sh.

USAGE: sh git2prop.sh [-t] [-T tag-filter] [-b] [-B branch-filter] [-p property-file] [-r git-repository]
 [-t] if specified tags will be added to the 'tags' property 
 [-T tag-filter] specified string will be used as prefix to filter tags
 [-b] if specified branches will be added to the 'branches' property
 [-B branch-filter] specified string will be used as prefix to filter branches
 [-p property-file] path to the property file to create/update
 [-r repository] URL or path to the git repository
