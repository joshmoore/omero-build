#!/usr/bin/env bash

set -e
set -u
set -x

for x in omero-model omero-common omero-romio omero-renderer omero-server;
do
    pushd $x
    ./gradlew clean publishToMavenLocal -x test -x javadoc
    popd
done

for x in omero-blitz;
do
    pushd $x
    # stop the daemon since we have to start a new one to honor JVM settings
    ./gradlew daemon --stop
    ./gradlew clean publishToMavenLocal -x test -x javadoc
    popd
done