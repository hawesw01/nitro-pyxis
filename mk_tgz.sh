#!/bin/bash

# get root directory
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
RPMBUILD_DIR=$DIR
SPECFILE=$DIR/SPECS/*.spec

if [[ -z $BUILD_NUMBER ]]; then
  echo "BUILD_NUMBER must be set."
  exit 1
fi

echo "Setting Release to $BUILD_NUMBER in spec file..."
sed -i "s/^Release:.\+/Release: $BUILD_NUMBER/" $SPECFILE

echo "Obtaining name, version and release number from $SPECFILE..."
RELEASENAME=`perl -ne 'print $1 if /Name:\s+(\S+)/' $SPECFILE`
RELEASEVERSION=`perl -ne 'print $1 if /Version:\s+(\S+)/' $SPECFILE`
RELEASENUMBER=`perl -ne 'print $1 if /Release:\s+(\d+)/' $SPECFILE`
RELEASE=$RELEASENAME-$RELEASEVERSION-$RELEASENUMBER

echo "Release version: $RELEASEVERSION"
echo "Release number: $RELEASENUMBER"
echo "Release: $RELEASE"

# create source archive and copy to SOURCES directory
echo "Creating source archive..."
mkdir -p SOURCES
tar -C src -czf $RELEASE.tar.gz .
mv $RELEASE.tar.gz SOURCES

# build the rpm
# NB _topdir macro is used to perform the build in $RPMBUILD_DIR rather than ~/rpmbuild
#echo "Building rpm, this will take a few minutes..."
#cd $RPMBUILD_DIR
#rpmbuild -bb --define "_topdir $RPMBUILD_DIR" $SPECFILE
