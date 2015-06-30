#!/bin/bash

# setup compiled dir
mkdir -p compiled
rm -rf compiled/*
cp -r launch compiled/launch
cp -r shared-config compiled/shared-config

if [ -z "${DOCKER_PROJECT_DIR}" ]; then
	echo
	echo "DOCKER_PROJECT_DIR is not set. Defaulting to ~/projects/ for your source code"
	echo "If you wish to change the location of your project source code, please specify"
	echo "DOCKER_PROJECT_DIR in your bashrc or zshrc and re-run ./setup-dirs.sh"
	echo
else
	DOCKER_PROJECT_DIR_REGEX=$(echo $DOCKER_PROJECT_DIR | sed 's/\//\\\//g')

	# replace references to ~/projects with the dir the user has set up
	find compiled/ -type f -exec sed -i '' -e "s/~\/projects/${DOCKER_PROJECT_DIR_REGEX}/g" {} +
fi
