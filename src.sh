#!/bin/bash

FILE=$(find . -type f -name "pom.xml" -o -name "build.gradle" -o -name "build.gradle.kts" -o -name "build.xml" | sed 's|^\./||')
if [ -z "$FILE" ]; then
	echo "No pom.xml or build.gradle found"
        exit 1
fi
        DIR=$(dirname "$FILE")
        F_NAME=$(basename "$FILE")
        echo "$DIR"
        echo "$F_NAME"
