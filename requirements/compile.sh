#!/bin/bash
#
# Generate a new conda lock file.
# Locked dependencies guarantees that builds will remain consistent over time.
#
# Usage:
#
#     $ ./src/requirements/compile.sh
#
# Command line arguments are passed to `conda-lock`.
# To upgrade a particular dependency, you can run:
#
#     $ ./src/requirements/compile.sh --upgrade python
#
# This will upgrade python to the latest version on conda-forge,
# while still satisfying the constraints in the environment.yaml file.

set -e

HERE="$( cd -- "$( realpath -- "$( dirname -- $0 )" )" && pwd )"
cd "$HERE"

SENTINEL='IN_DOCKER'
if [[ -z "${!SENTINEL}" ]] ; then
	MOUNT_DIR=/mnt/requirements
	echo "Running in docker"
	exec docker run \
		--rm -it \
		--volume "conda-pkg-cache:/opt/conda/pkgs" \
		--volume "$HERE:$MOUNT_DIR" \
		--env "$SENTINEL=true" \
		continuumio/miniconda3:latest \
		$MOUNT_DIR/compile.sh \
		"$@"
fi

conda config --remove channels defaults
conda config --add channels conda-forge

if ! conda list -f 'conda-lock' -e | grep 'conda-lock' -q ; then
	echo "Installing conda-lock"
	conda install --yes --verbose --channel conda-forge --override-channels conda-lock
fi

echo "Updating lock files"
platform="linux-64"
conda-lock lock --file "$HERE/environment.yml" --platform "$platform" "$@"
conda-lock render --platform "$platform"
