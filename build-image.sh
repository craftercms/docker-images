#!/bin/bash
TAG=$1
AUTHORING_BUNDLE=$2
DELIVERY_BUNDLE=$3

./gradlew clean
./gradlew buildMainImages -PauthoringBundle=$AUTHORING_BUNDLE -PdeliveryBundle=$DELIVERY_BUNDLE -Ptag=$TAG