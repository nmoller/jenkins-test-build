#!/usr/bin/env bash

##################################
#
# En ayant le token, l'appel 
# build.sh [token]
# déclanche le build. La configuration du projet jenkins est un peu weird...
# on saisit la valeur du jeton utilisé dans la config
# Pour les utilisateur windows... utiliser git-bash
# Au cas : https://stackoverflow.com/questions/50724407/curl-command-in-git-bash
# 
#
##################################

API_TOKEN=$1

if [ -z "$2" ]
then
	BRANCH=master
else
	BRANCH=$2
fi

CRUMB=$(curl -s "https://moller_n:${API_TOKEN}@jenkins.dev.uqam.ca/crumbIssuer/api/xml?xpath=concat(//crumbRequestField,\":\",//crumb)")
curl -I -X \
POST https://moller_n:${API_TOKEN}@jenkins.dev.uqam.ca/view/ENA/job/ENA/job/Moodle-build-01/buildWithParameters?branch=${BRANCH} \
-H "${CRUMB}"