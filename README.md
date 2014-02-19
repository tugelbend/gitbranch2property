gitbranch2property
==================

Creating a property file with all branches of a git repository for jenkins parameterized builds

This script creates a property file with all branches available in a git repository.
The proberty file can be used f.e. by jenkins to give the option which branch to use for a build.

It is recommended to use this script with cron, so the properties file is updated as
new branches appear (or old ones disappear) in the repo.

USAGE: sh git2prop.sh [Path or URL to git repository] [Path to properties file]
