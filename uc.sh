#!/bin/bash

# Get first part of archive name  
read -p "Enter name: " NAME
MODIFIED_NAME="[MFFMv12] $NAME"

# Get date string
DATE=`date +%y%m%d` 

# Version string
VERSION=`date +%y.%m.%d`

# Update name and version values in module.prop
sed -i "s/\(name=\).*/\1$MODIFIED_NAME/" module.prop
sed -i "s/\(versionCode=\).*/\1$DATE/" module.prop 
sed -i "s/\(version=\).*/\1$VERSION/" module.prop

# Zip name - replace spaces
ZIP_NAME=${NAME// /} 

# Construct archive name
ARCHIVE_NAME="$ZIP_NAME"_v"$DATE"[MFFMv12].zip

# Files to zip 
FILES="Files META-INF module.prop customize.sh"

# Create zip archive
zip -r "$ARCHIVE_NAME" $FILES

echo "Created archive: $ARCHIVE_NAME"